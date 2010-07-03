#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'
require 'find'
require 'optparse'


def load_index(index_file)
  index = {}
  File.readlines(index_file).each do |l|
    k, v = l.split(/ +/)
    index[k] = SimilarImage::ColorHistogram.parse(v)
  end
  index
end


options ={}
opts = OptionParser.new
opts.banner = <<EOB
Usage: #{opts.program_name} [options] IMG_DIR
EOB
opts.on('-a', '--append-to=FILE', 'Append to index file'){|v| options[:append] = v}
opts.on_tail('-h', '--help', 'Show this massage.'){print opts; exit}
opts.parse!

if options[:append]
  index = load_index(options[:append])
  out = open(options[:append], "a")
else
  index = {}
  out = $stdout
end
dir = ARGV.shift

Find.find(dir) do |f|
  next unless File.file?(f)
  next if index[f]
  $stderr.puts f
  hist = SimilarImage.color_histogram(f)
  out.puts "#{f}  #{hist}"
end

out.close
