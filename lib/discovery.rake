# Setup Tests
namespace :test do
  desc "Test Discovery plugin"
  Rake::TestTask.new(:discovery) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end
Rake::Task[:test].enhance do
  Rake::Task['test:discovery'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task["jenkins:unit"].enhance do
    Rake::Task['test:discovery'].invoke
  end
end
