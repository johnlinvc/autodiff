require "autodiff/version"
require "autodiff/dual_num"
require "autodiff/numeric"

module Autodiff

  module_function
  def gradient(at, &fun)
    if tmp_at = Array.try_convert(at)
      dual_at = tmp.map{ |v| DualNum.new(v)}
    else
      dual_at = DualNum.new(at, 1)
    end
    res = fun.(dual_at)
    res.epsilon
  end

end
