#!/usr/bin/env ruby

require 'shellwords'

filename, line = ARGV[0].split(':')
ij_dir = Dir.glob('/Applications/IntelliJ IDEA *.app')[0]
filename = Dir.glob("#{ENV['HOME']}/IdeaProjects/*/*/#{filename}")[0]
iml_files = Dir.glob("#{ENV['HOME']}/IdeaProjects/*/*/*.iml")
prj_dir = iml_files.map {|iml| File.dirname(iml)}.select {|prj_dir| filename.index(prj_dir)}[0]
unless filename.empty? and line.empty? and ij_dir.empty? then
  spawn("#{ij_dir.shellescape}/Contents/MacOS/idea #{prj_dir.shellescape} --line #{line} #{filename.shellescape}")
end
