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

  def test_gradient_can_do_1_plus_x
    assert_equal 1, Autodiff.gradient(0) { |x| 1 + x }
  end

  def test_gradient_can_do_1_minus_x
    assert_equal -1, Autodiff.gradient(0) { |x| 1 - x }
  end

  def test_gradient_can_do_1_point_5_minus_x
    assert_equal -1, Autodiff.gradient(0) { |x| 1.5 - x }
  end

  def test_gradient_can_handle_x_square
    assert_equal 2, Autodiff.gradient(1) { |x| x*x}
  end

  def test_gradient_can_handle_x_power_3
    assert_equal 12, Autodiff.gradient(2) { |x| x*x*x}
  end

  def test_gradient_can_handle_x_**_3
    assert_equal 12, Autodiff.gradient(2) { |x| x**3}
  end

  def test_gradient_can_handle_x_2_plus_x_3
    assert_equal 16, Autodiff.gradient(2) { |x| x*x + x*x*x}
  end
  def test_gradient_can_handle_x_2_minus_x_3
    assert_equal -8, Autodiff.gradient(2) { |x| x*x - x*x*x}
  end

  def test_gradient_can_do_sin
    assert_equal 1, Autodiff.gradient(0) { |x| Math.sin(x)}
  end
  def test_gradient_can_do_cos
    assert_equal -1, Autodiff.gradient(Math::PI/2) { |x| Math.cos(x)}
  end

  def test_gradient_can_handle_x_mul_y
    assert_equal [3,2], Autodiff.gradient([2,3]) { |x, y|x * y }
  end
end
