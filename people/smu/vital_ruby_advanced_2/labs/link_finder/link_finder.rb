require 'nokogiri'
require 'open-uri'

ARGV.each do |url|
  puts "Links for #{url}"
  body = open(url) { |f| f.read }
  doc = Nokogiri::HTML(body)
  doc.css('a').each do |link|
    href = link.attributes['href']

    puts "  #{}"
  end
end
