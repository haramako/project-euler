task :default do
  sh 'ruby', 'runner.rb', '-v'
end

task :all do
  sh 'ruby', 'runner.rb', *Dir.glob('../*').select{|f| File.directory? f}.to_a
end
