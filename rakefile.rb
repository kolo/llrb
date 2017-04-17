# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = %w[-c ./.rubocop.yml -D]
end

task default: %w[test]
