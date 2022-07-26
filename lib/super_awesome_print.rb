require 'super_awesome_print/version'
require 'super_awesome_print/configuration'
require 'awesome_print'

module Kernel
  def sap(msg)
    SuperAwesomePrint.blank_lines_top
    ap "*** #{Time.now} ***", :color => { :string => :green }
    ap msg.class if msg.respond_to?(:class)
    SuperAwesomePrint.print_caller_lines(caller)
    ap msg
    ap '*** END ***', :color => { :string => :green }
    SuperAwesomePrint.blank_lines_bottom
    msg
  end

  def sapf(msg)
    file = File.open(SuperAwesomePrint.config.log_file_path , 'a')
    file.puts("*** #{Time.now} ***")
    file.puts(" class: #{msg.class}") if msg.respond_to?(:class)
    lines = caller[0...SuperAwesomePrint.config.caller_lines].map do |line|
      root_path = SuperAwesomePrint.config.root_path
      if root_path.empty?
        line
      else
        line.gsub(root_path + '/', '')
      end
    end
    lines.each { |l| file.puts(' trace: ' + l) }
    file.puts(msg.inspect)
    file.puts('*** END ***')
  ensure
    file.close
  end
end

module SuperAwesomePrint
  class << self
    attr_writer :configuration
  end

  def self.print_caller_lines(caller_array)
    number_of_lines = config.caller_lines
    lines = caller_array[0...number_of_lines].map do |line|
      line.gsub(config.root_path + '/', '')
    end
    lines.each { |line| ap line, :color => { :string => :purpleish } }
  end

  def self.blank_lines_top
    # The first puts has no visible effect
    # So we want to puts once regardless of config
    puts
    config.blank_lines_top.times { puts }
  end

  def self.blank_lines_bottom
    config.blank_lines_bottom.times { puts }
  end

  def self.config
    SuperAwesomePrint.configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
