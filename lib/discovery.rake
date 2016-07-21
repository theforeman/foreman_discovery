# Setup Tests
namespace :test do
  desc "Test Discovery plugin"
  Rake::TestTask.new(:foreman_discovery) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end

  task :discovery => :foreman_discovery
end

Rake::Task["test:plugins"].enhance ['test:foreman_discovery']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:foreman_discovery'].invoke
  end
end
