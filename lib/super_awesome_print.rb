require 'super_awesome_print/version'
require 'super_awesome_print/configuration'
require 'awesome_print'

module Kernel
  private

  def sap(msg)
    SuperAwesomePrint.blank_lines_top
    ap "*** #{Time.now} ***", color: { string: :green }
    ap msg.class
    SuperAwesomePrint.trace(caller).each { |line| ap line, color: { string: :purpleish } }
    ap msg
    ap '*** END ***', color: { string: :green }
    SuperAwesomePrint.blank_lines_bottom
    msg
  end

  def sapf(msg)
    trace = SuperAwesomePrint.trace(caller)
    File.open(SuperAwesomePrint.config.log_file_path, 'a') do |file|
      file.puts("*** #{Time.now} ***")
      file.puts(" class: #{msg.class}")
      trace.each { |line| file.puts(" trace: #{line}") }
      file.puts(msg.inspect)
      file.puts('*** END ***')
    end
    msg
  end
end

module SuperAwesomePrint
  class << self
    attr_writer :configuration
  end

  def self.trace(backtrace)
    lines = backtrace.first(config.caller_lines)
    root = config.root_path.to_s.chomp('/')
    return lines if root.empty?

    lines.map { |line| line.sub(%r{\A#{Regexp.escape(root)}/}, '') }
  end

  def self.blank_lines_top
    # the first puts has no visible effect, so always print one
    puts
    config.blank_lines_top.times { puts }
  end

  def self.blank_lines_bottom
    config.blank_lines_bottom.times { puts }
  end

  def self.config
    configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
