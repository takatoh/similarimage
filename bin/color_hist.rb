#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'
require 'optparse'

options = {}
opts = OptionParser.new
opts.on('-i', '--index', 'print to index file.'){options[:index] = true}
opts.on('-h', '--help', 'show this message.'){ print opts; exit}
opts.parse!

if options[:index]
  ARGV.each do |file|
    hist = SimilarImage.color_histogram(file)
    puts "#{file}  #{hist.to_s}"
  end
else
  hist = SimilarImage.color_histogram(ARGV.shift)
  puts hist.to_s
end
