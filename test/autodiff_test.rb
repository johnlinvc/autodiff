require "test_helper"

class AutodiffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Autodiff::VERSION
  end

  def test_it_has_gradient_function
    refute_nil ::Autodiff.public_class_method(:gradient)
  end

  def test_gradient_can_handle_x_plus_1
    assert_equal 1, Autodiff.gradient(100) { |x| x + 1}
  end

  def test_gradient_can_handle_x_square
    assert_equal 2, Autodiff.gradient(1) { |x| x*x}
  end

  def test_gradient_can_handle_x_power_3
    assert_equal 12, Autodiff.gradient(2) { |x| x*x*x}
  end

  def test_gradient_can_handle_x_2_plus_x_3
    assert_equal 16, Autodiff.gradient(2) { |x| x*x + x*x*x}
  end
  def test_gradient_can_handle_x_2_minus_x_3
    assert_equal -8, Autodiff.gradient(2) { |x| x*x - x*x*x}
  end
end
