require 'rubygems'
require 'hmac-sha1'
require 'rest_client'

# constants
BASE_URL    = "http://api.iqengines.com/v1.2"
QUERY_URL   = BASE_URL + "/query/"
RESULT_URL  = BASE_URL + "/result/"
UPDATE_URL  = BASE_URL + "/update/"
OBJECTS_URL = BASE_URL + "/object/"

# checks whether or not item should exist in formdata
def form_data_exists? (item)
    return item != nil && item != false
end
class Api

    def initialize (key=nil, secret=nil)
        @key    = key || ENV['IQE_KEY']
        @secret = secret || ENV['IQE_SECRET']
    end

    def _build_signature (fields, files)
        rawstr = ""
        hmac       = HMAC::SHA1.new(@secret)
        files      = files.dup
        fields     = fields.dup

        files.each do |f|
            fields << [f[0], File.basename(f[1])]
        end
        fields = fields.sort
        fields.each do |f|
            rawstr << f[0] << f[1]
        end
        
        signature = hmac.update(rawstr)
    end

    def _signed_request (url, method, fields=nil, files=nil)
        files  = files != nil ? files.dup.select { |f| form_data_exists? f[1] } : []
        fields = fields != nil ? fields.dup.select { |f| form_data_exists? f[1] } : []
        fields = fields.map {|f| [f[0], f[1].to_s] }
        method = method.downcase
    
    
        fields << ["api_key", @key]
        fields << ["time_stamp", self._timestamp]
        signature = self._build_signature(fields, files)
        fields << ["api_sig", signature]
        files = files.map { |f| [f[0], File.new(f[1])] }
        fields.concat files
        puts fields
        response = RestClient.send(method, url, fields)
        return [signature, response]
    end

    def _timestamp ()
        return Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    def send_query (img, extra=nil, webhook=nil, device_id=nil, multiple_results=nil, modules=nil, json=true)
        files = [["img", img]]
        fields = [["webhook", webhook],
                  ["extra",extra], 
                  ["device_id",device_id], 
                  ["multiple_results",multiple_results], 
                  ["modules",modules],
                  ["json",json]]

        qid, response = self._signed_request(QUERY_URL, "POST", fields, files)
        return [qid, response]
    end

    def get_result (qid, json=true)
        fields = [["qid", qid], ["json", json]]
        sig, response = self._signed_request(RESULT_URL, "POST", fields)
        return response
    end

    def wait_results (device_id=nil, json=true)
        fields = [["device_id", device_id], ["json", json]]
        sig, response = self._signed_request(UPDATE_URL, "POST", fields)
        return response
    end

end

module  IQEngines
    def self.Api (key=nil,secret=nil)
        return Api.new(key,secret)
    end
end

