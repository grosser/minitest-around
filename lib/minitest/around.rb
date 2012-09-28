require 'minitest/around/version'

class MiniTest::Unit::TestCase
  def run_test(name)
    if defined?(around)
      around { |*args| __send__(name, *args) }
    else
      __send__(name)
    end
  end
end

class MiniTest::Spec
  def self.around(&outer)
    define_method(:around) do |&inner|
      if outer.arity == 1
        outer.call(inner)
      else
        inner.call *outer.call
      end
    end
  end
end
