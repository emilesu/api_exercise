namespace :dev do

  task :fetch_city => :environment do             #获取城市 => 通过外界
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => JUHE_CONFIG["api_key"]}   # GET请求的地址，以及密匙key
    data = JSON.parse(response.body)       #请求获取后的JSON格式资料，全部解析并存为"date"

    data["result"].each do |c|             #整理资料并存入数据库
      existing_city = City.find_by_juhe_id( c["id"] )           #之后在更新数据的时候，就可以进行比对、避免重复新增。
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end


  task :fetch_toutiao => :environment do
    puts "Fetck toutiao data..."
    response = RestClient.get "http://v.juhe.cn/toutiao/index", :params => { :key => JUHE_TOUTIAO_CONFIG["api_key"], :type => "yule" }
    data = JSON.parse(response.body)
    data["result"]["data"].each do |c|
      existing_toutiao = Toutiao.find_by_uniquekey( c["uniquekey"])
      if existing_toutiao.nil?
        Toutiao.create!( :uniquekey => c["uniquekey"],
                         :title => c["title"],
                         :category => c["category"],
                         :date => c["date"],
                         :author_name => c["author_name"],
                         :url => c["url"],
                         :thumbnail_pic_s => c["thumbnail_pic_s"],
                         :thumbnail_pic_s02 => c["thumbnail_pic_s02"],
                         :thumbnail_pic_s03 => c["thumbnail_pic_s03"] )
      end
    end

    puts "Total: #{Toutiao.count} Toutiaos"
  end

end
