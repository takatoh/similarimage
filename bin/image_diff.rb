#! ruby
# -*- encoding: utf-8 -*-

require 'rubygems'
require 'rmagick'
require 'optparse'


def get_pixel_color(img, x, y)
  img.get_pixels(x, y, 1, 1).first
rescue RangeError
  Magick::Pixel.new(0, 0, 0, 0)
end



options ={:output => "diff-image.jpg"}
opts = OptionParser.new
opts.banner = <<EOB
Usage: #{opts.program_name} [options] <image1> <image2>
EOB
opts.on('-o', '--output=FILENAME', 'Output to FILENAME.'){|v| options[:output] = v}
opts.on_tail('-h', '--help', 'Show this massage.'){print opts; exit}
opts.parse!


img1 = Magick::Image.read(ARGV.shift).first
img2 = Magick::Image.read(ARGV.shift).first

max_cols = [img1.columns, img2.columns].max
max_rows = [img1.rows, img2.rows].max

diff_img = Magick::Image.new(max_cols, max_rows) do
  self.background_color = 'black'
end

(1..(max_cols - 1)).each do |x|
  (1..(max_rows - 1)).each do |y|
    p1 = get_pixel_color(img1, x,y)
    p2 = get_pixel_color(img2, x,y)
    r = (p1.red - p2.red).abs
    g = (p1.green - p2.green).abs
    b = (p1.blue - p2.blue).abs
    diff_img.pixel_color(x, y, Magick::Pixel.new(r, g, b, 0))
  end
end

diff_img.write(options[:output])

