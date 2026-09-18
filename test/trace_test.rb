require 'test_helper'
require 'pathname'

class TraceTest < SuperAwesomePrintTestCase
  BACKTRACE = ['/app/models/user.rb:1', '/gems/app/lib/foo.rb:2', '/app/bar.rb:3'].freeze

  def setup
    super
    SuperAwesomePrint.config.caller_lines = 2
  end

  def test_keeps_paths_when_root_path_empty
    assert_equal BACKTRACE.first(2), SuperAwesomePrint.trace(BACKTRACE)
  end

  def test_strips_root_path_prefix_only
    SuperAwesomePrint.config.root_path = '/app'
    assert_equal ['models/user.rb:1', '/gems/app/lib/foo.rb:2'], SuperAwesomePrint.trace(BACKTRACE)
  end

  def test_accepts_trailing_slash_and_pathname
    ['/app/', Pathname.new('/app')].each do |root|
      SuperAwesomePrint.config.root_path = root
      assert_equal 'models/user.rb:1', SuperAwesomePrint.trace(BACKTRACE).first
    end
  end
end
