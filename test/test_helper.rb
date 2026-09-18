require 'super_awesome_print'
require 'minitest/autorun'

class SuperAwesomePrintTestCase < Minitest::Test
  def setup
    SuperAwesomePrint.configuration = nil
  end

  def teardown
    SuperAwesomePrint.configuration = nil
  end

  private

  def capture_uncolored(&block)
    capture_io(&block).first.gsub(/\e\[[\d;]*m/, '')
  end

  def with_rails(**methods)
    rails = Module.new
    methods.each { |name, value| rails.define_singleton_method(name) { value } }
    Object.const_set(:Rails, rails)
    yield
  ensure
    Object.send(:remove_const, :Rails)
  end
end
