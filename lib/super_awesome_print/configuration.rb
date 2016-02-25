class Configuration
  attr_accessor :caller_lines, :blank_lines_top, :blank_lines_bottom

  def initialize
    @caller_lines = 1
    @blank_lines_top = 0
    @blank_lines_bottom = 0
  end
end
