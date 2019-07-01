#!/usr/bin/env ruby
# coding: utf-8

# Project Euler Runner
require 'optparse'
require 'pp'
require 'timeout'
require 'json'

def run
end

def run_all(dir)
  report = []
  work_times = Hash.new # プログラム作成にかかった時間
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

      time_sec = nil
      result = nil
      Timeout::timeout($timeout) do
        start_at = Time.now
        result = __send__(mo[1])
        time_sec = (Time.now - start_at).to_f
        total_run_time += time_sec
      end

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

      report << {id: num, ok: ok, work_time: work_time, run_time: time_sec}
    rescue
      puts format("%04d     X FAILED %s", num, $!)
      report << {id: num, ok: 'X', work_time: 0, run_time: 0}
    end
  end
  all_result = if total == success then 'OK' else 'NG' end
  puts format("%s %d/%d work: %4dmin run: %3.1fs", all_result, success, total, total_work_time / 60, total_run_time)
  report
end

# Entry point
help = <<EOT
Project Euler Runner
Usage:
    $ ruby runner.rb [options] <dir> <problem-number> ...
Example:
    $ ruby runner.rb .  # run in this directory
    $ ruby runner.rb 30 31 # run only problem 30 and 31
Options:
EOT

$target = nil
$verbose = true
$timeout = 60*60
op = OptionParser.new(help)
op.on('-q','--quiet'){|v| $verbose = false }
op.on('-t','--timeout=SEC','Timeout per problem[sec]'){|v| $timeout = v.to_f }
args = op.parse(ARGV)

answers_array = IO.readlines('answers.txt')
          .map{|s| s.match /Problem\s+(\d+):\s+([0-9.]+)/ }
          .reject(&:nil?)
          .map{|mo| [mo[1].to_i, mo[2].to_f] }
$answers = Hash[answers_array]

args = ['.'] if args.empty?

# 可能ならforkする
def try_fork
  if RUBY_PLATFORM =~ /darwin/
    pid = fork do
      yield
    end
    Process.wait(pid)
  else
    yield
  end
end

args_num = args.map{|n| n.to_i}
if args_num.all?{|n| n != 0 }
  $target = args_num
  run_all('.')
else
  args.each do |dir|
    puts "Run at location `#{dir}`"
    report_name = File.basename(dir)
    if report_name == '.'
      report_name = 'report.json'
    else
      report_name = "report_#{report_name}.json"
    end

    try_fork do
      report = nil
      report = Dir.chdir(dir) { run_all('.') }
      IO.write(report_name, JSON.dump(report))
    end
  end
end

