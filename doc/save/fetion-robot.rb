#! /usr/bin/ruby
#author newdongyuwei@gmail.com
#run: jruby -rubygems fetion_code.rb
#
$KCODE = 'UTF-8'#解决中文乱码问题
%w(rubygems fileutils sinatra sinatra/base net/http net/https json).each{|lib|require lib}

class FetionRobot < Sinatra::Base
    @@Version = 0
   
    enable :sessions
    use Rack::Static, :urls => ["/images","/css","/js" ], :root => "public"
    set  :environment, :development
    set  :run, true
   
    def request(path,method,body,headers,hasVersion)
        if not body
            body =  "ssid=#{session['webim_sessionid']}"
        end
        if not headers
             headers = {
                'Referer' => 'https://webim.feixin.10086.cn/',
                'Content-Type' => 'application/x-www-form-urlencoded'
             }
        end
        http = Net::HTTP.new('webim.feixin.10086.cn', 443)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # turn off SSL warning
        if hasVersion
            path = "#{path}?Version=#{@@Version}"
            @@Version = @@Version + 1
        end
       
        if method == 'GET'
            return (resp, data = http.get(path, nil))
        else
            return (resp, data = http.post(path, body,headers))
        end
    end
   
    def get_code_img
        resp, data = request( '/WebIM/GetPicCode.aspx?Type=ccpsession','GET',nil,nil,false)
        dir = File.join(File.dirname(__FILE__),"public","images")
        FileUtils.mkdir_p(dir)
        File.open(File.join(dir,"fetion_code.jpeg"), "wb"){|file|
            file.write(resp.body)
            file.close
        }
        cookie = resp.response['set-cookie'].split(';')[0]
        session['ccpsession'] = cookie
    end
   
    def get_personal_info
        resp, data = request(  "/WebIM/GetPersonalInfo.aspx",'POST',nil,nil,true)
        puts data
        info = JSON(data)
        if info['rc'] == 200
            self.get_contact_list()
        end
    end
   
    def get_contact_list
        resp, data = request(  "/WebIM/GetContactList.aspx",'POST',nil,nil,true)
        info = JSON(data)
        puts data
        if info['rc'] == 200
            self.keep_alive
        end
    end
   
    def keep_alive
        Thread.new {
            loop {
                puts "---------------------------------keep_alive-----------------------------------"
                resp, data = request(  "/WebIM/GetConnect.aspx",'POST',nil,nil,true)
                info = JSON(data)
                puts info['rc']
                puts resp,data
                if info['rc']== 200
                    info['rv'].each do|item|
                        data = item['Data']
                        if item['DataType'] ==3 and data
                            self.send_msg(data['fromUid'],data['msg']+' - -feedfack')#ping-pong-test
                        end
                    end
                end
                sleep 5
             }
         }
    end
   
    def send_msg(to='660122812',msg='test中文',isSendSms='0')
        puts '--------------------send msg ------------------------------'
        body = "To=#{to}&IsSendSms=#{isSendSms}&msg=#{msg}&ssid=#{session['webim_sessionid']}"
        resp, data = request(  "/WebIM/SendMsg.aspx",'POST',body,nil,true)
        info = JSON(data)
        puts data
        if info['rc']== 200
            puts 'send msg ok!'
        end
        return data
    end
   
    get '/' do
        self.get_code_img()
         "<form action='/login'>\
            <LABEL for='UserName' >手机或飞信号</LABEL><input name='UserName'/>\
            <LABEL for='Pwd' >密码</LABEL><input name='Pwd'/>\
            <LABEL for='Ccp' >验证码</LABEL><input name='Ccp'/>\
            <img onclick='window.location.reload(true)'  src='/images/fetion_code.jpeg' />\
            <input type='submit' value='登录飞信'/>\
         </form>"
    end

    get '/login' do
        body = "UserName=#{params['UserName']}&Pwd=#{params['Pwd']}&OnlineStatus=400&Ccp=#{params['Ccp']}"
        puts body
        headers = {
            'Cookie' => session['ccpsession'],
            'Referer' => 'https://webim.feixin.10086.cn/',
            'Content-Type' => 'application/x-www-form-urlencoded'
         }
        resp, data = request(  "/WebIM/Login.aspx",'POST',body,headers,false)
        puts data
        rc = JSON(data)['rc']
        if rc == 200
            webim_sessionid = resp.response['set-cookie'].split('webim_sessionid=')[1].split(';')[0]
            session['webim_sessionid'] = webim_sessionid
            puts webim_sessionid
            self.get_personal_info()
            'login ok!'
        else
            redirect "/"
        end
    end
end

FetionRobot.run!({:port => 3000})


