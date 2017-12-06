#!/usr/bin/env ruby

# Project Euler Runner
require 'optparse'
require 'pp'

def run
end

def run_all(dir)
  puts "Run at location `#{dir}`"
  work_times = Hash.new
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
  total_work_time = 0
  total_run_time = 0
  files.each do |f|
    begin
      total += 1
      mo = f.match /(euler(\d+))\.rb/
      num = mo[2].to_i

      if $target
        next unless $target.include?(num)
      end
      
      fstat = File.stat(f)
      work_time = [(fstat.mtime - fstat.birthtime).to_i, 30*60].min
      total_work_time += work_time
      
      start_at = Time.now
      result = __send__(mo[1])
      time_sec = (Time.now - start_at).to_f
      total_run_time += time_sec
      
      ok = if not $answers[num]
             '?'
           elsif result == $answers[num]
             '.'
           else
             p [$answers[num], result]
             'X'
           end
      if ok == '.'
        success += 1
      end
      if $verbose || ok != '.'
        puts format("%04d     %s %3dmin %5.2fs %d", num, ok, work_time / 60, time_sec, result)
      end
    rescue
      puts format("%04d     X FAILED %s", num, $!)
    end
  end
  all_result = if total == success then 'OK' else 'NG' end
  puts format("%s %d/%d work: %4dmin run: %3.1fs", all_result, success, total, total_work_time / 60, total_run_time)
end

$answers = IO.readlines('answers.txt')
          .map{|s| s.match /Problem\s+(\d+):\s+([0-9.]+)/ }
          .reject(&:nil?)
          .map{|mo| [mo[1].to_i, mo[2].to_f] }
$answers = Hash[$answers]
$target = nil

op = OptionParser.new('Project Euler Runner')
op.on('-v','--verbose'){|v| $verbose = true }
op.on('-b','--benchmark'){|v| $benchmark = true }
args = op.parse(ARGV)

args = ['.'] if args.empty?

args_num = args.map{|n| n.to_i}
if args_num.all?{|n| n != 0 }
  $target = args_num
  run_all('.')
else
  args.each do |dir|
    pid = fork do
      run_all(dir)
    end
    Process.wait(pid)
  end
end
