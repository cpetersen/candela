# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "fileutils"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

desc "Build Rust extension"
task :build_ext do
  Dir.chdir("ext/candela") do
    puts "Building Rust extension..."
    status = system("ruby extconf.rb")
    raise "Failed to configure extension" unless status
    
    status = system("make")
    raise "Failed to build extension" unless status
    
    # Create lib directory if it doesn't exist
    FileUtils.mkdir_p("../../lib")
    
    # Set the correct extension based on platform
    ext = case RbConfig::CONFIG['host_os']
          when /darwin/
            'bundle'
          when /linux/
            'so'
          when /mingw|mswin/
            'dll'
          else
            raise "Unsupported platform: #{RbConfig::CONFIG['host_os']}"
          end
    
    # Copy to lib directory
    # Find the built extension file
    ext_source = case RbConfig::CONFIG['host_os']
                 when /darwin/
                   "target/release/libcandela.dylib"
                 when /linux/
                   "target/release/libcandela.so"
                 when /mingw|mswin/
                   "target/release/candela.dll"
                 else
                   raise "Unsupported platform: #{RbConfig::CONFIG['host_os']}"
                 end
                 
    FileUtils.cp(ext_source, "../../lib/candela_ext.#{ext}")
    
    puts "Rust extension built successfully"
  end
end

task build: :build_ext
task spec: :build_ext

task default: %i[spec standard]
