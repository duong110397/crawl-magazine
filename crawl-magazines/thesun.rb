#thesun.com
require 'nokogiri'
require 'open-uri'


queue_links = ["/news/6895769/stepmum-feral-teen-threw-eggs-flower-mum-admits-stupid-boy/"]

index_queue = 0

test = 0

while (index_queue < queue_links.length) && (test < 1000)

	test = test + 1
	begin
	
		doc = Nokogiri::HTML(open("https://www.thesun.co.uk/#{queue_links[index_queue]}"))
		
	  all_links = doc.xpath("//article//a")
	  
	all_links.each do |l|
		link = "https://www.thesun.co.uk#{l["href"]}".gsub(/\?.*$/, "")
		if link.match(/https:\/\/www.thesun.co.uk\/news/) != nil
			if !(queue_links.include? link)
			  queue_links.push link
			end
	  end
	end

	# puts queue_links.length

	puts "++++++++++++++++++++++++++++++++++++++"
	# puts queue_links

		doc.css("header.article__header").remove
		doc.css("div.article__meta").remove
		doc.css("div#bc-video-5815560536001").remove
		doc.css("blockquote.article__quote").remove
		doc.css("div.swiper-container").remove
		doc.css("ul.tags__list").remove
		doc.css("div.comments-header-wrap").remove
		doc.css("div.article-social__share-no").remove

		doc.search('//article//figure').remove

		doc.xpath("//article//p")[-1].remove

		 
	  tmp = doc.at('article').text.gsub("  ","")
																.gsub("\n"," ")
	  

	  file_output = File.open("data/thesun#{index_queue}.txt", "w")

	  title = doc.xpath("//article//p")[1]
	  file_output.puts title.text
  	file_output.puts ""

  	title.remove

	  file_output.puts tmp    
	  file_output.puts ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	  file_output.write "https://www.thesun.co.uk/#{queue_links[index_queue]}"

	rescue Exception => e
	  puts "---------bi loi---------------"
	  puts e
	  puts "------------------------------"
  end

  index_queue = index_queue + 1
end


