require 'test_helper'
require 'pathname'

class ConfigurationTest < SuperAwesomePrintTestCase
  def test_defaults
    config = SuperAwesomePrint::Configuration.new
    assert_equal 1, config.caller_lines
    assert_equal 0, config.blank_lines_top
    assert_equal 0, config.blank_lines_bottom
    assert_equal '', config.root_path
    assert_equal File.join(Dir.pwd, 'sapf.log'), config.log_file_path
  end

  def test_defaults_in_rails
    with_rails(root: Pathname.new('/app')) do
      config = SuperAwesomePrint::Configuration.new
      assert_equal '/app', config.root_path
      assert_equal '/app/log/sapf.log', config.log_file_path
    end
  end

  def test_rails_constant_without_root
    with_rails do
      assert_equal '', SuperAwesomePrint::Configuration.new.root_path
    end
  end

  def test_no_top_level_constant
    refute Object.const_defined?(:Configuration, false)
  end

  def test_configure
    SuperAwesomePrint.configure { |config| config.caller_lines = 5 }
    assert_equal 5, SuperAwesomePrint.config.caller_lines
  end
end
