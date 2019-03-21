require "test_helper"

class AutodiffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Autodiff::VERSION
  end

  def test_it_has_gradient_function
    refute_nil ::Autodiff.public_class_method(:gradient)
  end

  def x_2(x)
    x * x
  end

  def test_gradient_can_handle_x_2
    Autodiff.gradient(1) { |x| x_2(x)}
  end
end
