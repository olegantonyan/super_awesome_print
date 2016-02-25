require 'super_awesome_print/version'
require 'super_awesome_print/configuration'
require 'awesome_print'

def sap(msg)
  blank_lines_top
  ap "*** #{Time.now} ***", color: { string: :green }
  ap msg.class if msg.respond_to?(:class)
  print_caller_lines(caller)
  ap msg
  ap '*** END ***', color: { string: :green }
  blank_lines_bottom
end

def print_caller_lines(caller_array)
  number_of_lines = config.caller_lines
  lines = caller_array[0...number_of_lines].map do |line|
    line.gsub(Rails.root.to_s + '/', '')
  end
  lines.each { |line| ap line, color: { string: :purpleish } }
end

def blank_lines_top
  # The first puts has no visible effect
  # So we want to puts once regardless of config
  puts
  config.blank_lines_top.times { puts }
end

def blank_lines_bottom
  config.blank_lines_bottom.times { puts }
end

def config
  SuperAwesomePrint.configuration
end

module SuperAwesomePrint
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
