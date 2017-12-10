#!/usr/bin/env ruby
# coding: utf-8

# HTMLレポート

require 'erb'
require 'json'
require 'pp'

MAX = 50
reports = []

Report = Struct.new(:name, :list, :total_count, :success_count, :total_run_time)

Dir.glob('report_*.json') do |f|
  name = f.match(/report_(.+)\.json$/)[1]
  list = JSON.parse(IO.read(f), symbolize_names: true)
  success_count = list.select{|r| r[:ok] == '.'}.size
  hash = Hash[list.map{|r| [r[:id], r]}]
  report = Report.new(name, hash, list.size, success_count)

  (1..MAX).each do |n|
    unless report.list[n]
      report.list[n] = {id: n, ok:'X', run_time: 0, work_time: 0}
    end
  end

  report.total_run_time = list.reduce(0){|m,r| m + r[:run_time] }
  
  reports << report
end

names = reports.map{|r| r.name}
# pp reports

def median(ary)
  ary = ary.select{|x| x > 0 }
  ary = [0] if ary.size == 0
  mid = ary.length / 2
  sorted = ary.sort
  ary.length.odd? ? sorted[mid] : 0.5 * (sorted[mid] + sorted[mid - 1])
end

def show_report(r, median=nil)
  n = r[:run_time]
  if r[:ok] == '.'
    if n == 0 || median == 0
      ratio = 1.0
    else
      ratio = Math.log(n / median * Math::E)
    end
    case
    when ratio < 0
      col = "#08f"
    when ratio < 0.3
      col = "#0ff"
    when ratio < 1.7
      col = "#fff"
    when ratio < 3.0
      col = "#ff0"
    else
      col = "#f80"
    end
    format('<td style="background-color:%s">%3.3f</td>', col, n)
  else
    format('<td style="background-color:#888">X</td>')
  end
end

puts ERB.new(IO.read('reporter.html.erb')).result(binding)

