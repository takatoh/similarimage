#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'


file = ARGV.shift
hist = SimilarImage.color_histogram(file)
puts hist.to_s

