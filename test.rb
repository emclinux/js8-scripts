#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

def mkdata(tr)
  itxt = tr.text
  data = itxt.lstrip.rstrip.split(':')
end
# Fetch and parse HTML document
doc = Nokogiri::HTML(open('http://www.levinecentral.com/ham/grid_square.php?Call=kg5spr'))

puts "### Or mix and match."
data = doc.search('p')

data.each {|d|
  case d.text
  when /Name:/
    data = mkdata(d)
    printf "%-8s : %-20s\n", data[0], data[1]
    notificaton.concat("#{data[0]}\t: #{data[1]}\n")
  when /QTH:/
    data = mkdata(d)
    printf "%-8s : %-20s\n", data[0], data[1]
    notificaton.concat("#{data[0]}\t: #{data[1]}\n")
    city = data[1]
  when /State:/
    data = mkdata(d)
    printf "%-8s : %-20s\n", data[0], data[1]
    notificaton.concat("#{data[0]}\t: #{data[1]}\n")
    state = data[1]
  when /Country:/
    data = mkdata(d)
    printf "%-8s : %-20s\n", data[0], data[1]
    notificaton.concat("#{data[0]}\t: #{data[1]}\n")
  when /Grid:/
    data = mkdata(d)
    printf "%-8s : %s\n", data[0], data[1]
  end
}

