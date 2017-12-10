task :default do
  sh 'ruby', 'runner.rb'
end

task :all do
  sh 'ruby', 'runner.rb', '-q', *Dir.glob('../*').select{|f| File.directory? f}.to_a
end

task :report do
  sh 'ruby reporter.rb >output.html'
end
