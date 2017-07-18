# frozen_string_literal: true

require './robot.rb'
require './colorize'

robot = Robot.new(0, 5, 0, 5)

puts '========================= SYSTEM IS ONLINE ========================'.blue

File.foreach('input.txt').with_index do |command, line_num|
  command = command.gsub(/\n.*/, '')
  puts "##{line_num}: #{command}".light_blue
  robot.execute_command(command)
end

puts '========================== SHUTTING DOWN =========================='.blue
