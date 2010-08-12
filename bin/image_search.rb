#! ruby
# -*- encoding: utf-8 -*-

require 'similar_image'
require 'optparse'
require 'erb'


TEMPLATE = <<EOT
<html>
<head>
  <title>Similar images</title>
</head>

<body>
  <h1>Similar images</h1>

  <table>
    <tr><th>Score</th><th>Image</th><th>Path</th></tr>
    <%- @result.each do |r| -%>
    <tr>
      <td><%= "%8.6f" % r[0] %></td>
      <td><img src="<%= r[1] %>" /></td>
      <td><%= r[1] %></td>
    </tr>
    <%- end -%>
  </table>
</body>
</html>
EOT

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


@options ={:html => false}
opts = OptionParser.new
opts.banner = <<EOB
Usage: #{opts.program_name} [options] INDEX IMAGE
EOB
opts.on('--html', 'Format to HTML'){|v| @options[:html] = true}
opts.on_tail('-h', '--help', 'Show this massage.'){print opts; exit}
opts.parse!


index = load_index(ARGV.shift)
src_image = ARGV.shift
@result = search(index, src_image)
if @options[:html]
  script = ERB.new(TEMPLATE, nil, "-")
  script.run
else
  @result.each {|i| puts "%8.6f  %s" % i }
end


