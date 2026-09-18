module SuperAwesomePrint
  class Configuration
    attr_accessor :caller_lines, :blank_lines_top, :blank_lines_bottom, :root_path, :log_file_path

    def initialize
      @caller_lines = 1
      @blank_lines_top = 0
      @blank_lines_bottom = 0
      @root_path = rails_root
      @log_file_path = @root_path.empty? ? File.join(Dir.pwd, 'sapf.log') : File.join(@root_path, 'log', 'sapf.log')
    end

    private

    def rails_root
      defined?(::Rails) && ::Rails.respond_to?(:root) ? ::Rails.root.to_s : ''
    end
  end
end
