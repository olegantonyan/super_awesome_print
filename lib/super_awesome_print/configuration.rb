class Configuration
  attr_accessor :caller_lines, :blank_lines_top, :blank_lines_bottom, :root_path, :log_file_path

  def initialize
    @caller_lines = 1
    @blank_lines_top = 0
    @blank_lines_bottom = 0
    @root_path = defined?(Rails) ? Rails.root.to_s : ''
    @log_file_path = @root_path.empty? ? Dir.pwd + '/sapf.log' : @root_path + '/log/sapf.log'
  end
end
