require "autodiff/dual_num"

module DualNumWrappable
  def dual_method(meth)
    orig_meth = "predual_#{meth.to_s}".to_sym
    dual_meth = "dual_#{meth.to_s}".to_sym
    alias_method orig_meth, meth
    define_method(meth) { |*args|
      if args.any?{ |arg| arg.kind_of?(Autodiff::DualNum)}
        dual_args = args.map(&:to_dual)
        epsilon_coef = self.public_send(dual_meth, *dual_args)
        real_args = dual_args.map(&:to_float)
        r = self.public_send(orig_meth, *real_args)
        Autodiff::DualNum.new(r, epsilon_coef)
      else
        self.public_send(orig_meth, *args)
      end
    }
  end
end

module Math
  class << self
    extend(DualNumWrappable)
    dual_method(:sin)
    def dual_sin(n)
      cos(n.real) * n.epsilon
    end

    dual_method(:cos)
    def dual_cos(n)
      -sin(n.real) * n.epsilon
    end

    dual_method(:tan)
    def dual_tan(n)
      ((1/cos(n.real)) ** 2) * n.epsilon
    end

  end
end
