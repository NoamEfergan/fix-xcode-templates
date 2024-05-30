#!/usr/bin/ruby
# frozen_string_literal: true

require 'fileutils'

def get_user_input(prompt, default)
  print "#{prompt} "
  input = gets.chomp
  if input.empty?
    default
  else
    input
  end
end

def change_directory(path)
  begin
    Dir.chdir(path)
  rescue Errno::ENOENT
    puts "The directory #{path} does not exist."
  rescue Errno::EACCES
    puts "Permission denied to access #{path}."
  rescue StandardError => e
    puts "Failed to change directory: #{e.message}"
  end
end

def fix_swift_file_template
  target_path = 'File Templates/MultiPlatform/Source/Swift File.xctemplate'

  unless Dir.exist?(target_path)
    puts "The target directory #{target_path} does not exist."
    return
  end
  change_directory(target_path)
  puts "Current directory after change: #{Dir.pwd}"

  source_dir = File.expand_path(File.join(__dir__, 'swift_templates'))
  destination_dir = Dir.pwd

  puts "Source directory: #{source_dir}"
  puts "Destination directory: #{destination_dir}"

  unless Dir.exist?(source_dir)
    puts "The source directory #{source_dir} does not exist."
    return
  end

  begin
    FileUtils.cp_r("#{source_dir}/.", destination_dir)
    puts "Copied contents from #{source_dir} to #{destination_dir}"
  rescue Errno::ENOENT
    puts "The source directory #{source_dir} does not exist."
  rescue Errno::EACCES
    puts "Permission denied to access #{source_dir} or #{destination_dir}."
  rescue StandardError => e
    puts "Failed to copy files: #{e.message}"
  end
end

def fix_swiftui_file_template
  target_path = 'File Templates/MultiPlatform/User Interface/SwiftUI View.xctemplate'
  unless Dir.exist?(target_path)
    puts "The target directory #{target_path} does not exist."
    return
  end
  change_directory(target_path)
  puts "Current directory after change: #{Dir.pwd}"

  source_dir = File.expand_path(File.join(__dir__, 'swiftui_template'))
  destination_dir = Dir.pwd

  puts "Source directory: #{source_dir}"
  puts "Destination directory: #{destination_dir}"

  unless Dir.exist?(source_dir)
    puts "The source directory #{source_dir} does not exist."
    return
  end

  begin
    FileUtils.cp_r("#{source_dir}/.", destination_dir)
    puts "Copied contents from #{source_dir} to #{destination_dir}"
  rescue Errno::ENOENT
    puts "The source directory #{source_dir} does not exist."
  rescue Errno::EACCES
    puts "Permission denied to access #{source_dir} or #{destination_dir}."
  rescue StandardError => e
    puts "Failed to copy files: #{e.message}"
  end
end

def main
  template_path = get_user_input("Enter path to Xcode, or leave empty for default value (`/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/`): ", "/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/")
  change_directory(template_path)
  fix_swift_file_template
  change_directory(template_path)
  fix_swiftui_file_template
end

main
