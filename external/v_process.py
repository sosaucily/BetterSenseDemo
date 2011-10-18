import os
import pickle
import subprocess
import shlex
import sys
import re
import pprint

def main():
	processedVideoPath = "processedVideos"
	videoSubDir = "video"
	imagesSubDir = "images"
	videoInputPath = "videos"
	
	running_os = ""
	if (sys.platform.find("linux") >= 0):
		running_os = "linux"
	else:
		running_os = "osx"

	completedVideos = []
	
	dirList=os.listdir(videoInputPath)

	for i in range(len(dirList)):
		videoName = dirList[i]
		if (videoName.find("README") > -1):
			continue
#		f = open((str(infoFilePath) + "" + str(dirList[i]))[:-3] + "txt" , 'w')

		print ("scanning video " + videoInputPath +"/" + videoName)

		clean_video_name_temp = re.sub("\s","_",videoName)
		clean_video_name2 = re.sub("\W","",clean_video_name_temp[0:-4])
		clean_video_name = re.sub("_[_]*","_",clean_video_name2) + videoName[-4:]
		video_format = videoName[-3:]

		if (running_os == "linux"):
			md5_shell_command = "md5sum \"%s\"" % (videoInputPath +"/" + videoName)
		elif (running_os == "osx"):
			md5_shell_command = "md5 \"%s\"" % (videoInputPath +"/" + videoName)
		else:
			md5_shell_command = "md5sum \"%s\"" % (videoInputPath +"/" + videoName)
		
		md5_args = shlex.split(md5_shell_command)
		print ("Running md5sum command: " + md5_shell_command )
		video_md5sum_b = subprocess.check_output(md5_args)
		video_md5sum_long = video_md5sum_b.decode("utf-8")
		
		video_md5sum = ""
				
		#On OS X with the md5 command, we want the last
		if (running_os == "osx"):
			intBreak = video_md5sum_long.rfind(" ")
			video_md5sum = video_md5sum_long[intBreak+1:intBreak+33]
		#On linux with the md5sum command, we want the first segment
		elif (running_os == "linux"):
			intBreak = video_md5sum_long.find(" ")
			video_md5sum = video_md5sum_long[0:intBreak]
		else:
			intBreak = video_md5sum_long.find(" ")
			video_md5sum = video_md5sum_long[0:intBreak]
		
		
		print ("Got video md5sum of " + video_md5sum)
		
		os.makedirs(processedVideoPath + "/" + video_md5sum)
		os.makedirs(processedVideoPath + "/" + video_md5sum + "/" + videoSubDir)
		os.makedirs(processedVideoPath + "/" + video_md5sum + "/" + imagesSubDir)

		ffmpeg_info_command = "ffmpeg -i \"%s\"" % ( videoInputPath +"/" + videoName )

		args = shlex.split (ffmpeg_info_command)
		p = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

		stdout_value, stderr_value = p.communicate()
		print ("\tcombined output: " + repr(stdout_value) + " -- " + repr(stderr_value))
		
		resolution = ""
		video_info = repr(stderr_value)
		vid_res = re.search ('\d\d\d[\d]?x\d\d\d[\d]?' , video_info)
		if (vid_res != None):
			video_res = vid_res.group(0)

		if (video_res == None or video_res == ""):
			video_res = ""
		else:
			resolution = getResolution(video_res)
		
		ffmpeg_shell_command = "ffmpeg -i \"%s\" -r %s -s %s \"%s/%s/%s/image_%%04d.jpg\"" % ( videoInputPath +"/" + videoName, ".5", str(resolution["width"]) + "x" + str(resolution["height"]), processedVideoPath, video_md5sum, imagesSubDir)
		
		print ("running ffmpeg -> " + ffmpeg_shell_command)
		
		args = shlex.split(ffmpeg_shell_command)
		p = subprocess.call(args)
		
		#Convert video to FLV if necessary, and move into place
		if (video_format.lower() != "flv"):
			ffmpeg_convert_flv = "ffmpeg -i \"%s\" -ab 96 -ar 44100 -f flv -s %s \"%s.flv\"" % (videoInputPath + "/" + videoName, str(resolution["width"]) + "x" + str(resolution["height"]), videoInputPath + "/" + clean_video_name[0:-4])
			print ("running flv conversion: " + ffmpeg_convert_flv)
			args = shlex.split(ffmpeg_convert_flv)
			p = subprocess.call(args)

			move_shell_command = "mv \"%s\" \"%s/%s/%s\"" % (videoInputPath + "/" + clean_video_name[0:-4] + ".flv", processedVideoPath, video_md5sum, videoSubDir)
			print ("running flv move: " + move_shell_command)
			args = shlex.split(move_shell_command)
			p = subprocess.call(args)

		
		move_shell_command = "mv \"%s\" \"%s/%s/%s\"" % (videoInputPath + "/" + videoName, processedVideoPath, video_md5sum, videoSubDir)
		print ("running move: " + move_shell_command)		
		args = shlex.split(move_shell_command)
		p = subprocess.call(args)
	

		print ("Process Results:")
		print ("md5sum: " + video_md5sum)
		print ("resolution: " + str(resolution["width"]) + "x" + str(resolution["height"]))
		print ("file name: " + clean_video_name[0:-4] + ".flv")
		print ("full path to file: " + videoInputPath + "/" + clean_video_name[0:-4] + ".flv")
		#print dict to file
		#pickle.dump(results, f)
		#f.write(results)
		#f.close()
		completedVideos.append ({'md5':video_md5sum,'res':str(resolution["width"]) + "x" + str(resolution["height"]), 'filename':clean_video_name[0:-4] + ".flv"})
		#sys.exit()

	for i in completedVideos:
		pprint.pprint (i)



def getResolution(video_res):
	x_index = video_res.find("x")
	resolution = {"width":"", "height":""}
	if (x_index > 0):
		width = int(video_res[0:x_index])
		height = int(video_res[(x_index+1):len(video_res)])
		if (width > 640):
			ratio = height / width
			width = 640
			height = int(round(640 * ratio))
		if (height > 640): #This is pretty strange, height is greater than width...
			ratio = width / height
			height = 640
			width = int (round(640 * ratio))
		resolution["width"]=width
		resolution["height"]=height
	return (resolution)


if __name__ == "__main__":
    main()

