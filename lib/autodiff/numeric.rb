module DualNumConvertible
  def dual_op(op)
    orig_op = "predual_#{op.to_s}".to_sym
    alias_method orig_op, op
    define_method(op) { |other|
      if other.kind_of?(Autodiff::DualNum)
        self.to_dual.public_send(op, other)
      else
        self.public_send(orig_op, other)
      end
    }
  end
end

class Integer
  extend DualNumConvertible
  dual_op(:+)
  dual_op(:-)
end
