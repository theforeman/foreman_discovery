# Setup Tests
namespace :test do
  desc "Test Discovery plugin"
  Rake::TestTask.new(:discovery) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    if ENV['FILE'] || ENV['TEST']
      t.pattern = ENV['FILE'] || ENV['TEST']
    else
      t.pattern = "#{test_dir}/**/*_test.rb"
    end
    t.verbose = true
    t.warning = false
  end
end
Rake::Task[:test].enhance do
  Rake::Task['test:discovery'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  # The "unit" tests also include system tests
  Rake::Task["jenkins:unit"].enhance(['webpack:compile']) do
    Rake::Task['test:discovery'].invoke
  end
end
