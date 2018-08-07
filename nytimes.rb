#nytimes.com
require 'nokogiri'
require 'open-uri'

queue_links = ["https://www.nytimes.com/2016/07/21/world/asia/1mdb-malaysia-us-assets-seized.html"]

index_queue = 0

test = 0

while (index_queue < queue_links.length) && (test < 1000)

  test = test + 1
  begin

    doc = Nokogiri::HTML(open(queue_links[index_queue]))
    
    all_link = doc.xpath("//article//a") 

    all_link.each do |l|
      link = l["href"].gsub(/\?.*$/, "")
      if link.match(/https:\/\/www.nytimes.com\/20\d\d\/\d\d\/\d\d/) != nil
        if !(queue_links.include? link)
          queue_links.push link
        end
      end
    end

    # puts queue_links

    puts "++++++++++++++++++++++++++++++++++++++"


      puts queue_links[index_queue]
      # puts "link chuan"

      doc.search('//article//figcaption').remove
      doc.search('//article//figure').remove
      script = doc.xpath('//article//script').remove
      style = doc.xpath('//article//style').remove
      

      p_tag = doc.xpath('//article//p')
      p_tag[-2].remove
      p_tag[-1].remove
      
      doc.css("div.css-3glrhn").remove
      doc.css("div.css-acwcvw").remove
      doc.css("div.bottom-of-article").remove
      doc.css("div.RelatedCoverage-relatedcoverage--LmkKX").remove
      doc.css("h3.kicker").remove
      doc.css("div#story-meta-footer").remove
      doc.css("div#newsletter-promo").remove
      doc.css("footer.story-footer").remove
      doc.css("section#whats-next").remove
      doc.css("div#top-wrapper").remove
      doc.css("div#sponsor-wrapper").remove
      doc.css("div.supported-by").remove


      file_output = File.open("data/nytimes#{index_queue}.txt", "w")
      

      title = doc.xpath('//article//header//h1')[0]
      file_output.puts title.text
      file_output.puts ""

      title.remove
      
      tmp = doc.css('article').text.gsub("\n", "")
                                   .gsub(/<.*?>/, " ").strip.squeeze
                                   .gsub("Continue reading the main story", "")
      file_output.puts tmp
      
      file_output.puts ""
      file_output.puts queue_links[index_queue]

      file_output.close

  rescue Exception => e
    puts "---------bi loi---------------"
    puts e
    puts "------------------------------"
  end


  index_queue = index_queue + 1
end
