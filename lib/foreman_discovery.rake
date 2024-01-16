# Setup Tests
namespace :test do
  desc "Test Discovery plugin"
  Rake::TestTask.new(:foreman_discovery) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = ENV['FILE'] || ENV['TEST'] || "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end
Rake::Task[:test].enhance do
  Rake::Task['test:foreman_discovery'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  # The "unit" tests also include system tests
  Rake::Task["jenkins:unit"].enhance(['webpack:compile']) do
    Rake::Task['test:foreman_discovery'].invoke
  end
end
