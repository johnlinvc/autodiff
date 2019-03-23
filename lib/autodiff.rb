require "autodiff/version"
require "autodiff/dual_num"
require "autodiff/numeric"
require "autodiff/math"

module Autodiff

  module_function
  def gradient(at, &fun)
    if tmp_at = Array.try_convert(at)
      dual_at = tmp_at.map{ |v|  v.to_dual }
      dual_at_mat = dual_at.size.times.map do |i|
        dual_at.map.each_with_index do |v, j|
          if i==j
            v.to_one_epsilon
          else
            v
          end
        end
      end
      gradient_ary = dual_at_mat.map do |row|
        fun.(*row)
      end
      gradient_ary.map(&:epsilon)
    else
      dual_at = DualNum.new(at, 1)
      res = fun.(dual_at)
      res.epsilon
    end
  end

end
