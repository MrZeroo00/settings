#!/usr/bin/env ruby

require 'shellwords'
require 'uri'

url = URI.unescape(ARGV[0])
filename, line = url.split(':///')[1].split(':')
ij_dir = Dir.glob('/Applications/IntelliJ IDEA *.app')[0]
filename = Dir.glob("#{ENV['HOME']}/IdeaProjects/*/*/#{filename}")[0] unless filename.index('IdeaProjects')
iml_files = Dir.glob("#{ENV['HOME']}/IdeaProjects/*/*/*.iml")
prj_dir = iml_files.map {|iml| File.dirname(iml)}.select {|prj_dir| filename.index(prj_dir)}[0]
unless filename.empty? and line.empty? and ij_dir.empty? then
  exec("#{ij_dir.shellescape}/Contents/MacOS/idea #{prj_dir.shellescape} --line #{line} #{filename.shellescape}")
end
