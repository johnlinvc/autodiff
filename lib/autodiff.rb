require "autodiff/version"
require "autodiff/dual_num"
require "autodiff/numeric"
require "autodiff/math"

module Autodiff

  private
  module_function
  def real_ary_to_dual_gradient_mat(ary)
    dual_ary = ary.map{ |v|  v.to_dual }
    dual_ary.size.times.map do |i|
      dual_ary.map.each_with_index do |v, j|
        i==j ? v.to_one_epsilon : v
      end
    end
  end

  # TODO: add ability to raise when a not supported math func is called
  module_function
  def gradient(at, &fun)
    if at_ary = Array.try_convert(at)
      dual_at_mat = real_ary_to_dual_gradient_mat(at_ary)
      gradient_ary = dual_at_mat.map do |row|
        fun.(*row)
      end
      gradient_ary.map(&:epsilon)
    else
      gradient([at], &fun)[0]
    end
  end

end
