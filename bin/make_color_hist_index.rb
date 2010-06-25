#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'
require 'find'

dir = ARGV.shift

Find.find(dir) do |f|
  next unless File.file?(f)
  $stderr.puts f
  hist = SimilarImage.color_histogram(f)
  puts "#{f}  #{hist}"
end
