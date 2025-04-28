# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

desc "Build Rust extension"
task :build_ext do
  Dir.chdir("ext/candela") do
    sh "cargo build --release"
    sh "cp target/release/libcandela.dylib ../../lib/candela_ext.so"
  end
end

task build: :build_ext
task spec: :build_ext

task default: %i[spec standard]
