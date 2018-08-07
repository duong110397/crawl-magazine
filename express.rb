require 'nokogiri'
require 'open-uri'

queue_links = ["/news/uk/996095/Brexit-news-brexit-fact-sarah-jane-mee-video-live-Mark-Littlewood-IEA"]

index_queue = 0

test = 0 

while (index_queue < queue_links.length) && (test < 1000)

	test = test + 1
	begin
	
		doc = Nokogiri::HTML(open("https://www.express.co.uk/#{queue_links[index_queue]}"))
	    
	  all_links = doc.xpath("//article//a")
	  
    all_links.each do |l|
    	if "https://www.express.co.uk#{l["href"]}".match(/https:\/\/www.express.co.uk\/news/) != nil
        if !(queue_links.include? l["href"])
          queue_links.push l["href"]
        end
      end
    end

    puts "++++++++++++++++++++++++++++++++++++++"
    puts queue_links[index_queue]

	  doc.css("div.publish-info").remove
	  doc.css("a.hoverException").remove
	  doc.css("div.htmlappend").remove
	  doc.css("div.two-related-articles").remove
	  doc.css("div.pull-quote").remove
	  doc.css("div.slideshow").remove
	  doc.css("li.active").remove

	  doc.search('//article//script').remove
	  doc.search('//article//header//div').remove
	  doc.search('//header//h2').remove
	  
	  file_output = File.open("data/express#{index_queue}.txt", "w")

	  title = doc.xpath("//header//h1")
	  file_output.puts title.text

    title.remove

    tmp = doc.at('article').text.gsub("  ","")
																.gsub("\n\n","")

	  file_output.puts tmp    
	  file_output.puts ""
	  file_output.write "https://www.express.co.uk/#{queue_links[index_queue]}"

	rescue Exception => e
	  puts "---------bi loi---------------"
	  puts e
	  puts "------------------------------"
  end

  index_queue = index_queue + 1
end
