#mirror.com
require 'nokogiri'
require 'open-uri'

queue_links = ["https://www.mirror.co.uk/news/uk-news/englands-most-unequal-town-life-13002058"]

index_queue = 0

test = 0

while (index_queue < queue_links.length) && (test < 1000)

	test = test + 1
	begin
	
		doc = Nokogiri::HTML(open(queue_links[index_queue]))
		
		doc.xpath("//article//a")[0].remove
	  all_links = doc.xpath("//article//a")
	  
	all_links.each do |l|
		if "#{l["href"]}".match(/https:\/\/www.mirror.co.uk\/news/) != nil
			if !(queue_links.include? l["href"])
			  queue_links.push l["href"]
			end
	  end
	end

	# puts queue_links

	puts "++++++++++++++++++++++++++++++++++++++"
	# puts queue_links[index_queue]

		  doc.css('div.byline').remove
		  doc.css('div.video-preloader').remove
		  doc.css('div.article-type').remove
		  doc.css('div.embedded-image-grid').remove
		  doc.css('div#social-follow').remove
		  doc.css('div.tag-list').remove
		  doc.css('div.state-logout').remove

		  doc.search('//article//figure').remove
		  doc.search('//article//form').remove
		  doc.search('//article//aside').remove

		  p = doc.xpath('//article//p')
		  header = doc.xpath('//article//h1').text
		  tmp = doc.at('article').text.gsub("#{header}","#{header}\n\n")
		  														.gsub(p[0].text,"#{p[0].text}\n")

		  file_output = File.open("data/mirror#{index_queue}.txt", "w")

		  file_output.puts tmp    
		  file_output.puts ""                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
		  file_output.write queue_links[index_queue]

	rescue Exception => e
	  puts "---------bi loi---------------"
	  puts e
	  puts "------------------------------"
  end

  index_queue = index_queue + 1
end