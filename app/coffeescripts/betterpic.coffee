root = exports ? this
$ ->
	toolID = 1

	gCanvasElement = root.$('#layer1')
	myCanvas = gCanvasElement[0].getContext '2d'
	betterpic = new Image
	betterpic.onload = () ->
		myCanvas.drawImage betterpic, 0, 0, root.imagew, root.imageh
	betterpic.src = root.imagepath

	halmaOnClick = (e) ->
		if e.pageX? and e.pageY?
			x = e.pageX
			y = e.pageY
		else
			x = e.clientX + document.body.scrollLeft +
				document.documentElement.scrollLeft
			y = e.clientY + document.body.scrollTop +
				document.documentElement.scrollTop

		x -= gCanvasElement[0].offsetLeft
		y -= gCanvasElement[0].offsetTop

		coords = gCanvasElement.offset()
		x -= coords["left"]
		y -= coords["top"]
		root.$('#iqeinfo_cx')[0].value = x
		root.$('#iqeinfo_cy')[0].value = y
    
		drawSelectionCircle x, y, myCanvas, toolID

	gCanvasElement[0].addEventListener 'click', halmaOnClick, false 		

	drawSelectionCircle = (x, y, canvasContext, id) ->
		canvasContext.clearRect 0, 0, root.imagew, root.imageh
		myCanvas.drawImage betterpic, 0, 0, root.imagew, root.imageh
		canvasContext.beginPath()
		canvasContext.arc x, y, getRad(id), 0, Math.PI * 2, false
		canvasContext.closePath()
		canvasContext.strokeStyle = "#E89"
		canvasContext.lineWidth = "4"
		canvasContext.stroke()

	root.$('#circleToolBox1').click () ->
		setSelectedTool 1
	
	root.$('#circleToolBox2').click () ->
		setSelectedTool 2

	root.$('#circleToolBox3').click () ->
		setSelectedTool 3

	setSelectedTool = (id) ->
		toolID = id
		clearSelectionBoxes()
		root.$('#iqeinfo_cradius').value = getRad id
		root.$("#circleToolBox#{id}")[0].style.border = "solid #000 4px"
	
	clearSelectionBoxes = () ->
		elem.style.border = "solid #000 1px" for elem in root.$('.toolselector')

	getRad = (id) ->
		10 + (15*id)

	root.$('#cImageInfo').submit () ->
		$('#layer1').hide("puff", {}, 600, () -> 
			myCanvas.clearRect 0, 0, root.imagew, root.imageh
			$(this).show()
			)
		return

	root.clearAndNextPic = (newImagePath, newimagew, newimageh) ->
		root.imagew = newimagew
		root.imageh = newimageh
		gCanvasElement = root.$('#layer1')
		myCanvas = gCanvasElement[0].getContext '2d'
		myCanvas.clearRect 0, 0, root.imagew, root.imageh
		betterpic = new Image
		betterpic.onload = () ->
			myCanvas.drawImage betterpic, 0, 0, root.imagew, root.imageh
		betterpic.src = newImagePath
		return

	setSelectedTool toolID
