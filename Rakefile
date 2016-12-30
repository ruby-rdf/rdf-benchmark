require 'rake/clean'
require 'bundler'
require 'rspec/core/rake_task'

load 'lib/tasks/berlin.rake'

Bundler::GemHelper.install_tasks

CLEAN.include %w(bsbmtools)

desc 'Run tests'
RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.rspec_opts = ['--backtrace'] if ENV['CI']
end

task default: [:rspec]
