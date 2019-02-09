# -*- encoding: utf-8 -*-

require "similar_image/similar_image"
require "similar_image/version"


module SimilarImage

  def self.color_histogram(file)
    img = Magick::Image.read(file).first
    ColorHistogram.new(img)
  end

end   # of module SimilarImage
