# -*- encoding: utf-8 -*-
#
# SimilarImage
#

require 'rubygems'
require 'rmagick'


module SimilarImage

  def self.color_histogram(file)
    img = Magick::Image.read(file).first
    ColorHistogram.new(img)
  end


  ## classes:

  class ColorHistogram
    def initialize(image)
      @hist = []
      (0..63).each{|c| @hist[c] = 0}
      image.each_pixel do |pixel, c, r|
        @hist[to_bin(a(pixel.red), a(pixel.green), a(pixel.blue))] += 1
      end
    end

    def serialize
      @hist.map{|c| c.to_s}.join(":")
    end

    alias :to_s :serialize

    def inspect
      "#<ColorHistogram: #{serialize}>"
    end

    private

    def a(n)
      (n/64).floor
    end

    def to_bin(r, g, b)
      r * 4 * 4 + g * 4 + b * 1
    end
  end   # of ColorHistogram


end   # of SimilarImage

