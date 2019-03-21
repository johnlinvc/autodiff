require "test_helper"

class AutodiffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Autodiff::VERSION
  end

  def test_it_has_gradient_function
    refute_nil ::Autodiff.public_class_method(:gradient)
  end

  def x_square(x)
    x * x
  end

  def x_power_3(x)
    x * x * x
  end

  def test_gradient_can_handle_x_square
    assert_equal 2, Autodiff.gradient(1) { |x| x_square(x)}
  end

  def test_gradient_can_handle_x_power_3
    assert_equal 12, Autodiff.gradient(2) { |x| x_power_3(x)}
  end
end
