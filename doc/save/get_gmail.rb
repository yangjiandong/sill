#! /usr/bin/ruby  
#author newdongyuwei@gmail.com  
  
require 'uri'  
require 'net/http'  
require 'net/https'  
require 'rexml/document'  
  
#https://user:password@mail.google.com/mail/feed/atom  
 gmail_feed_url = "https://mail.google.com/mail/feed/atom"  
 user="young.jiandong"  
 password = "asdfghjkl"  
   
 url = URI.parse(gmail_feed_url)  
 http = Net::HTTP.new(url.host, url.port)#port is 443  
 http.verify_mode = OpenSSL::SSL::VERIFY_NONE # turn off SSL warning  
 http.use_ssl = true  
 http.start do |http|  
     request = Net::HTTP::Get.new(url.path)  
     request.basic_auth(user, password)  
     response = http.request(request)  
     puts response.code  
     puts response.body  
   
     doc = REXML::Document.new(response.body)  
     feed_list = []  
     doc.root.elements.to_a("//entry").each do|entry|  
         feed_list.push([entry.elements["title"].text.strip(),entry.elements["summary"].text.strip(),  
         entry.elements["author"].elements["name"].text.strip()].join("-"))  
     end  
     puts feed_list #title-summary-name  
 end  

