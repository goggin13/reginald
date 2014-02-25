require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :default => "spec:unit"

desc "Run unit examples"
RSpec::Core::RakeTask.new("spec:unit") do |task|
 task.pattern = "spec/reginald/*_spec.rb"
end
