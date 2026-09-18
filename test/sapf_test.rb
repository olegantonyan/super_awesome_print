require 'test_helper'
require 'tmpdir'

class SapfTest < SuperAwesomePrintTestCase
  def setup
    super
    @dir = Dir.mktmpdir
    SuperAwesomePrint.config.log_file_path = File.join(@dir, 'sapf.log')
  end

  def teardown
    FileUtils.remove_entry(@dir)
    super
  end

  def test_returns_argument
    msg = 'hello'
    assert_same msg, sapf(msg)
  end

  def test_writes_entry
    sapf([1, 'two']); line = __LINE__
    expected = /\A\*\*\* .+ \*\*\*\n class: Array\n trace: #{Regexp.escape(__FILE__)}:#{line}:in .+\n\[1, "two"\]\n\*\*\* END \*\*\*\n\z/
    assert_match expected, log
  end

  def test_appends
    sapf(1)
    sapf(2)
    assert_equal 2, log.scan('*** END ***').size
  end

  def test_trace_relative_to_root_path
    SuperAwesomePrint.config.root_path = File.dirname(__FILE__)
    sapf(1); line = __LINE__
    assert_includes log, " trace: #{File.basename(__FILE__)}:#{line}:"
  end

  def test_raises_original_error_for_unwritable_path
    SuperAwesomePrint.config.log_file_path = File.join(@dir, 'missing', 'sapf.log')
    assert_raises(Errno::ENOENT) { sapf(1) }
  end

  private

  def log
    File.read(SuperAwesomePrint.config.log_file_path)
  end
end
