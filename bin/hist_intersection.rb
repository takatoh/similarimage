#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'
require 'optparse'

options = {}
opts = OptionParser.new
opts.on('-i', '--index=FILE', 'print to index file.'){|v| options[:index] = v}
opts.on('-h', '--help', 'show this message.'){ print opts; exit}
opts.parse!

if options[:index]
  index = {}
  File.readlines(options[:index]).each do |l|
    k, v = l.split(/ +/)
    index[k] = SimilarImage::ColorHistogram.parse(v)
  end
  hist_1 = index[ARGV.shift]
  hist_2 = index[ARGV.shift]
else
  hist_1 = SimilarImage::ColorHistogram.parse(File.read(ARGV.shift))
  hist_2 = SimilarImage::ColorHistogram.parse(File.read(ARGV.shift))
end

puts hist_1.intersection(hist_2)

