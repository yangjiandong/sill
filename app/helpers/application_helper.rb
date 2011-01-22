module ApplicationHelper

  # hack for firefox. The 'alt' parameter on images does not work. Firefox uses 'title' instead.
  # http://snippets.dzone.com/posts/show/2917
  def image_tag(location, options={})
    options[:title] ||= options[:alt]
    super(location, options)
  end

  def sill_version
    #Java::OrgSonarServerPlatform::Platform.getServer().getVersion()
    '1.0.0'
  end

  #i 原始数 n 要保留的小数位数，flag=1 四舍五入 flag=0 不四舍五入
  def num_f(i,n,flag)
    y = 1
    n.times do |x|
      y = y*10
    end
    if flag==1
     (i*y).round/(y*1.0)
    else
     (i*y).floor/(y*1.0)
    end
  end

  # shortcut for the method is_admin?() without parameters. Result is kept in cache.
  def administrator?
    @is_administrator ||=
    begin
      is_admin?
    end
  end

  # JFree Eastwood is a partial implementation of Google Chart Api
  def gchart(parameters, options={})
    image_tag("#{ApplicationController.root_context}/gchart?#{parameters}", options)
  end

  # Piechart for a distribution string or measure (foo=1;bar=2)
  def piechart(distribution, options={})
    chart = ""
    data=nil
    if distribution
      data=(distribution.kind_of? ProjectMeasure) ? distribution.data : distribution
    end

    if data && data.size > 0
      labels = []
      values = []
      skipZeros = options[:skipZeros].nil? ? true : options[:skipZeros]
      options[:skipZeros] = nil
      data.split(';').each do |pair|
        splitted = pair.split('=')
        value = splitted[1]
        next if skipZeros && value.to_i == 0
        labels << splitted[0]
        values << value
      end
      if labels.size > 0
        options[:alt] ||= ""
        chart = gchart("chs=#{options[:size] || '250x90'}&chd=t:#{values.join(',')}&cht=p&chl=#{labels.join('|')}", options)
      end
    end
    chart
  end

  def barchart(options)
    percent = (options[:percent] || 100).to_i
    return '' if percent<=0

    width = (options[:width] || 150).to_i
    color = (options[:color] ? "background-color: #{options[:color]};" : '')
    "<div class='barchart' style='width: #{width}px'><div style='width: #{percent}%;#{color}'></div></div>"
  end

  def chart(parameters, options={})
    image_tag("#{ApplicationController.root_context}/chart?#{parameters}", options)
  end

  #----------------------------------------------------------------------------
  def one_submit_only(form)
    { :onsubmit => "$('#{form}_submit').disabled = true" }
  end

  # Leia mais: http://rafael.adm.br/p/simple-tooltip-helper-for-ruby-on-rails/#ixzz17nyhRSDo
  def my_tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:title] = options[:tooltip]
    html_options[:class] = html_options[:class] || 'tooltip'
    content_tag("span", content, html_options)
  end

  # 大写金额
  def self.ConvertNumToChinese(num)
    chineseNumArr=['零','壹','贰','叁','肆','伍','陆','柒','捌','玖']
    chinesePosArr=['万','仟','佰','拾','亿','仟','佰','拾','万','仟','佰','拾','元','角','分']
    chineseNum=''
    chinesePos=''
    strChinese=''
    nzero=0
    strNum=(num*100).to_i.to_s
    i=0
    length=strNum.length
    posValue=0
    pos=chinesePosArr.length-length
    while i<length
      posValue=strNum[i].chr.to_i

      if(i!=(length-3) && i!=(length-7) && i!=(length-11) && i!=(length-15))
        if(posValue==0)
          chineseNum=''
          chinesePos=''
          nzero+=1
        else
          if(nzero!=0)
            chineseNum=chineseNumArr[0]+chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          else
            chineseNum=chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          end
        end
      else
        if(posValue!=0 && nzero!=0)
          chineseNum=chineseNumArr[0]+chineseNumArr[posValue]
          chinesePos=chinesePosArr[pos+i]
          nzero=0
        else
          if(posValue!=0 && nzero==0)
            chineseNum=chineseNumArr[posValue]
            chinesePos=chinesePosArr[pos+i]
            nzero=0
          else
            if(length>=11)
              chineseNum=''
              nzero+=1
            else
              chineseNum=''
              chinesePos=chinesePosArr[pos+i]
              nzero+=1
            end
          end
        end
      end
      if(i==(length-11) || i==(length-3))
        chinesePos=chinesePosArr[pos+i]
      end
      strChinese=strChinese+chineseNum+chinesePos
      if(i==(length-1) && posValue==0)
        strChinese=strChinese+'整'
      end
      i+=1
    end

    strChinese
  end

  # 判断浏览器
  def client_browser_name
    user_agent =
    request.env['HTTP_USER_AGENT'].downcase
    if user_agent =~ /msie/i
                                  "Internet Explorer"
    elsif user_agent =~ /konqueror/i
                                  "Konqueror"
    elsif user_agent =~ /gecko/i
                                  "Mozilla"
    elsif user_agent =~ /opera/i
                                  "Opera"
    elsif user_agent =~ /applewebkit/i
                                  "Safari"
    else
                                  "Unknown"
    end
  end

  def get_database_time
    Property.get_database_time()
  end

  def get_database_date
    Property.get_database_date()
  end

  # cloud_tag
  def tags
    # cloud_tag(tag_url_hash)
    cloud_tag({"tag1" => "www.tag1.com", "tag2" => "www.tag2.com"})
  end
  
  def tag_url_hash 
    returning r = { } do 
      Blog.tag_counts.map(&:name).each do |t|
        r[t] = CGI.unescape(tags_url(:q => t))
      end
    end
  end
 
end
