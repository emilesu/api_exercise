namespace :dev do
  task :fetck_city => :environment do             #获取城市 => 通过外界
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => "93ab6eb51049059848f3f06f2b9e16df"}   # GET请求的地址，以及密匙key
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
end
