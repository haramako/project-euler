#!/usr/bin/env ruby

# Project Euler Runner
require 'optparse'

def run(dir)
  puts "Run at location `#{dir}`"
  files = Dir.glob("#{dir}/euler*.rb").sort
  files.each do |f|
    begin
      load f
    rescue
      puts $!
    end
  end
  total = 0
  success = 0
  files.each do |f|
    begin
      total += 1
      mo = f.match /(euler(\d+))\.rb/
      num = mo[2].to_i
      result = __send__(mo[1])
      ok = if not $answers[num]
             '?'
           elsif result = $answers[num]
             '.'
           else
             'X'
           end
      if ok == '.'
        success += 1
      end
      if $verbose || ok != '.'
        puts format("%04d     %s %d", num, ok, result)
      end
    rescue
      puts format("%04d     X FAILED %s", num, $!)
    end
  end
  all_result = if total == success then 'OK' else 'NG' end
  puts format("%s %d/%d", all_result, success, total)
end

$answers = IO.readlines('answers.txt')
          .map{|s| s.match /Problem\s+(\d+):\s+([0-9.]+)/ }
          .reject(&:nil?)
          .map{|mo| [mo[1].to_i, mo[2].to_f] }
$answers = Hash[$answers]

op = OptionParser.new('Project Euler Runner')
op.on('v','--verbose'){|v| $verbose = true }
args = op.parse(ARGV)

args = ['.'] if args.empty?

args.each do |dir|
  pid = fork do
    run(dir)
  end
  Process.wait(pid)
end


