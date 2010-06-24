require 'rubygems'
require 'rmagick'

include Magick


def a(n)
  (n/64).floor
end

def to_bin(r, g, b)
  r * 4 * 4 + g * 4 + b * 1
end

def serialize(ary)
  ary.map{|c| c.to_s}.join(":")
end


file = ARGV.shift
img = Image.read(file).first

hist = []
(0..63).each{|c| hist[c] = 0}

img.each_pixel do |pixel, c, r|
  hist[to_bin(a(pixel.red), a(pixel.green), a(pixel.blue))] += 1
end

puts serialize(hist)

