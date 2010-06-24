hist_1 = File.read(ARGV.shift).split(":").map{|l| l.to_i}
hist_2 = File.read(ARGV.shift).split(":").map{|l| l.to_i}


d = hist_1.inject(0){|i,j| i + j}
intersection = hist_1.zip(hist_2).map do |a|
  a.min
end.inject(0){|i,j| i + j}

puts intersection.to_f / d

