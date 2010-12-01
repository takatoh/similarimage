require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name             = "similarimage"
  s.version          = "0.3.1"
  s.summary          = "Search similar images."
  s.description      = "Search similar images."
  s.platform         = Gem::Platform::RUBY
  s.add_dependency     "rmagick"
  s.author           = "takatoh"
  s.email            = "takatoh.m@gmail.com"
  s.homepage         = ""
  s.bindir           = "bin"
  s.executables      = %w( simimg image_diff )
  s.files            = %w( bin/simimg
                           bin/image_diff
                           lib/similar_image.rb
                         )
  s.require_path     = "lib"
  s.has_rdoc         = true
  s.rdoc_options     = %w( -c utf-8 --main SimilarImage --line-numbers )
#  s.extra_rdoc_files = %w( README )
end
