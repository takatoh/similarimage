# -*- encoding: utf-8 -*-
#
# SimilarImage
#

require 'rmagick'


module SimilarImage

  def self.color_histogram(file)
    img = Magick::Image.read(file).first
    ColorHistogram.new(img)
  end


  ## classes:

  class ColorHistogram
    attr_reader :hist

    def initialize(image)
      @hist = [0] * 64
      if image.class == Magick::Image
        image.each_pixel do |pixel, c, r|
          @hist[to_bin(a(pixel.red), a(pixel.green), a(pixel.blue))] += 1
        end
      else
        @hist = image
      end
    end

    def self.parse(str)
      self.new(str.split(":").map{|l| l.to_i})
    end

    def serialize
      @hist.map{|c| c.to_s}.join(":")
    end

    alias :to_s :serialize

    def inspect
      "#<ColorHistogram: #{serialize}>"
    end

    def intersection(other)
      d = @hist.inject(0){|i,j| i + j}
      intsec = @hist.zip(other.hist).map{|a| a.min}.inject(0){|i,j| i + j}
      intsec.to_f / d
    end

    private

    def a(n)
#      n >> 14
      while n >= 4
        n = n / 2
      end
      n
    end

    def to_bin(r, g, b)
      (r << 4) + (g << 2) + b
    end
  end   # of ColorHistogram


end   # of SimilarImage

