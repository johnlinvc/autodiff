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

  def test_gradient_can_do_1_mul_x
    assert_equal 1, Autodiff.gradient(0) { |x| 1 * x }
  end

  def test_gradient_can_do_1_div_x
    assert_equal -0.25, Autodiff.gradient(2) { |x| 1 / x }
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

  def test_gradient_can_do_tan
    assert_in_epsilon 2, Autodiff.gradient(Math::PI/4) { |x| Math.tan(x)}
  end

  def test_gradient_can_log
    assert_in_epsilon 2, Autodiff.gradient(0.5) { |x| Math.log(x)}
  end

  def test_gradient_can_do_exp
    assert_in_epsilon Math::E, Autodiff.gradient(1) { |x| Math.exp(x)}
  end

  def test_gradient_can_handle_x_mul_y
    assert_equal [3,2], Autodiff.gradient([2,3]) { |x, y|x * y }
  end

  def assert_ary_in_delta(expected, actual)
    expected.zip(actual).each { |e,a|
      assert_in_delta e, a
    }
  end

  def test_gradient_can_do_x_cos_y
    assert_ary_in_delta [-1,0], Autodiff.gradient([2,Math::PI]) { |x, y|x * Math.cos(y) }
  end

  def test_gradient_can_handle_compounded_2d_method
    actual = Autodiff.gradient([20, 30]) {|x,y| 10.times.reduce(0){|acc, n| acc + 2 * x + 3 * y} }
    assert_equal [20,30], actual
  end

  def test_it_can_handle_triop
    actual = Autodiff.gradient(40) { |x|
      x > 42 ? 2 * x : x
    }
    assert_equal 1, actual
  end

  def test_it_can_handle_triop
    actual = Autodiff.gradient(50) { |x|
      x > 42 ? 2 * x : x
    }
    assert_equal 2, actual
  end
end
