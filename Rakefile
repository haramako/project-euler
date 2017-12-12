# coding: utf-8

REPOS = ['kaser', 'ryu', 'okazaki', 'ariyoshi', 'suzuki', 'harada']


desc '自分の分を実行する'
task :default do
  sh 'ruby', 'runner.rb'
end

desc '全員分を実行する'
task :all do
  sh 'ruby', 'runner.rb', '-q', *REPOS
end

desc 'レポートを出力する'
task :report do
  sh 'ruby reporter.rb >output.html'
end

desc '１日分のレポートを保存する'
task :daily_report do
  date = Time.now.strftime('%Y-%m-%d')
  dir = "daily_report/#{date}"
  mkdir_p dir
  cp 'output.html', "#{dir}/index.html"
  cp FileList['report_*.json'], dir
  Dir.chdir 'daily_report' do
    html = ["<html><h1>Project Euler Daily Report</h1><ul>"]
    FileList['20*'].each do |f|
      html << "<li><a href='./#{f}/index.html'>#{f}</li>"
    end
    html << "</ul></body></html>"
    IO.write('index.html', html.join("\n"))
  end
end

desc '全員分のリポジトリをアップデートする'
task :update do
  REPOS.each do |f|
    Dir.chdir(f) do
      sh "git pull"
    end
  end
end

desc 'ファイルをアップロードする'
task :upload do
  sh 'rsync --iconv=UTF8-MAC,UTF-8 -avz daily_report/ tdadmin@133.242.235.150:/home/tdadmin/dfz/Doc/_site/daily_report/'
end
