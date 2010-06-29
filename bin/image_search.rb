#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'


def load_index(index_file)
  index = {}
  File.readlines(index_file).each do |l|
    k, v = l.split(/ +/)
    index[k] = SimilarImage::ColorHistogram.parse(v)
  end
  index
end

def search(index, image)
  source_hist = index[image] || SimilarImage.color_histogram(image)
  result = []
  index.each do |filename, hist|
    result << [source_hist.intersection(hist), filename]
  end
  result.sort{|a,b| b[0] <=> a[0]}[0..9]
end


index = load_index(ARGV.shift)
src_image = ARGV.shift
search(index, src_image).each do |i|
  puts "%8.6f  %s" % i
end


