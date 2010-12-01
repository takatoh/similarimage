require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rubygems'


Rake::RDocTask.new(:rdoc) do |rd|
  rd.rdoc_files.include("lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
  rd.title = "SimilarImage - Search similar images."
  rd.options << "-c" << "utf-8"
  rd.options << "-m" << "SimilarImage"
  rd.options << "--line-numbers"
end


gemspec = instance_eval(File.read("similarimage.gemspec"))

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = true
#  pkg.need_tar = true
end

