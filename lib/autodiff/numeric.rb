require "autodiff/dual_num"

class Integer
  extend Autodiff::DualNumConvertible
  dual_op(:+)
  dual_op(:-)
end

class Float
  extend Autodiff::DualNumConvertible
  dual_op(:+)
  dual_op(:-)
end
