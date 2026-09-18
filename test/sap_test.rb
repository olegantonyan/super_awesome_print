require 'test_helper'
require 'delegate'

class SapTest < SuperAwesomePrintTestCase
  class Wrapper < SimpleDelegator
    def show
      sap(__getobj__)
    end
  end

  def test_returns_argument
    msg = 'hello'
    result = nil
    capture_io { result = sap(msg) }
    assert_same msg, result
  end

  def test_output
    out = capture_uncolored { sap(42) }; line = __LINE__
    expected = /\A\n"\*\*\* .+ \*\*\*"\nInteger < Numeric\n"#{Regexp.escape(__FILE__)}:#{line}:in .+"\n42\n"\*\*\* END \*\*\*"\n\z/
    assert_match expected, out
  end

  def test_trace_relative_to_root_path
    SuperAwesomePrint.config.root_path = File.dirname(__FILE__)
    out = capture_uncolored { sap(1) }; line = __LINE__
    assert_includes out, "\"#{File.basename(__FILE__)}:#{line}:"
  end

  def test_caller_lines
    SuperAwesomePrint.config.caller_lines = 2
    out = capture_uncolored { sap(1) }
    assert_equal 2, out.lines.grep(/\A".+:\d+:in /).size
  end

  def test_blank_lines
    SuperAwesomePrint.config.blank_lines_top = 2
    SuperAwesomePrint.config.blank_lines_bottom = 3
    out = capture_uncolored { sap(1) }
    assert out.start_with?("\n\n\n\"***")
    assert out.end_with?("\"*** END ***\"\n\n\n\n")
  end

  def test_private
    refute_respond_to Object.new, :sap
    refute_respond_to Object.new, :sapf
  end

  def test_inside_delegator
    result = nil
    out = capture_uncolored { result = Wrapper.new([1]).show }
    assert_equal [1], result
    assert_includes out, 'Array < Object'
  end
end
