require "bundler/setup"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Run RSpec tests"
task :test => :spec

desc "Run StandardRB linter"
task :lint do
  sh "bundle exec standardrb"
end

desc "Auto-fix StandardRB issues"
task :fix do
  sh "bundle exec standardrb --fix"
end

desc "Run all checks (tests + lint)"
task :check => [:spec, :lint]
