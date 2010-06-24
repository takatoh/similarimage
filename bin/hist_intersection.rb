#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'


hist_1 = SimilarImage::ColorHistogram.parse(File.read(ARGV.shift))
hist_2 = SimilarImage::ColorHistogram.parse(File.read(ARGV.shift))

puts hist_1.intersection(hist_2)

