#!/usr/bin/env ruby

# Project Euler Runner

files = Dir.glob('euler*.rb').sort

files.each do |f|
  load f
end

files.each do |f|
  mo = f.match /(euler(\d+))\.rb/
  num = mo[2].to_i
  result = __send__(mo[1])
  puts format("%04d     %d", num, result)
end
