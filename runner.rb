#!/usr/bin/env ruby
# coding: utf-8

# Project Euler Runner
require 'optparse'
require 'pp'
require 'timeout'
require 'json'

def run_all
  report = []
  work_times = Hash.new # プログラム作成にかかった時間
  files = Dir.glob("euler*.rb").sort
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
           elsif result == $answers[num]
             '.'
           else
             p [$answers[num], result]
             'X'
           end
      if ok == '.'
        success += 1
      end
      
      puts format("%04d     %s %d", num, ok, result)

    rescue
      puts format("%04d     X FAILED %s", num, $!)
    end
  end
  all_result = if total == success then 'OK' else 'NG' end
  puts format("%s %d/%d", all_result, success, total)
  report
end

# Entry point
answers_array = IO.readlines('answers.txt')
          .map{|s| s.match /Problem\s+(\d+):\s+([0-9.]+)/ }
          .reject(&:nil?)
          .map{|mo| [mo[1].to_i, mo[2].to_f] }
$answers = Hash[answers_array]

run_all
