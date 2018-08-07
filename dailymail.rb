#dailymail
require 'nokogiri'
require 'open-uri'

queue_links = ["http://www.dailymail.co.uk/news/article-5963117/Models-file-suit-against-Wilhelmina-Major-Elite-MC2-Models-Click-agencies.html"]

index_queue = 0

test = 0

while (index_queue < queue_links.length) && (test < 1000)

	test = test + 1
	begin
	
		doc = Nokogiri::HTML(open(queue_links[index_queue]))
	    
	  all_links = doc.xpath("//body//a")
	  
    all_links.each do |l|
    	link = "http://www.dailymail.co.uk#{l["href"]}".gsub(/\?.*$/, "")
    																								 .gsub(/\#.*$/, "")
    	if link.match(/http:\/\/www.dailymail.co.uk\/news\/article-/) != nil
        if !(queue_links.include? link)
          queue_links.push link
        end
      end
    end

    puts queue_links[index_queue]
 
    puts "++++++++++++++++++++++++++++++++++++++"

	  doc.css("div.billboard_wrapper").remove
	  doc.search("//html//script").remove
	  doc.css("div#articleIconLinksContainer").remove
	  doc.css("ul.mol-bullets-with-font").remove
	  doc.css("p.author-section").remove
	  doc.css("p.byline-section").remove
	  doc.css("span.mol-style-bold").remove
	  doc.css("p.imageCaption").remove
	  doc.css("div#p-19").remove
	  doc.css("div#p-23").remove
	  doc.css("div.adHolder").remove
	  doc.css("div#taboola-below-main-column").remove
	  doc.css("div#most-watched-videos-wrapper").remove
	  doc.css("div.column-content").remove
	  doc.css("div#most-read-news-wrapper").remove
	  doc.css("div#reader-comments").remove
	  doc.css("div#external-source-links").remove

	  file_output = File.open("data/dailymail#{index_queue}.txt", "w")

	  title = doc.xpath("//body//h2")[0]
	  file_output.puts title.text
    file_output.puts ""

    title.remove

		tmp = doc.css('div#js-article-text').text.gsub("\n", "").gsub(/<.*?>/, " ").strip.squeeze

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
