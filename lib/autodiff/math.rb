require "autodiff/dual_num"

module DualNumWrappable
  def dual_method(meth)
    orig_meth = "predual_#{meth.to_s}".to_sym
    dual_meth = "dual_#{meth.to_s}".to_sym
    alias_method orig_meth, meth
    define_method(meth) { |*args|
      if args.any?{ |arg| arg.kind_of?(Autodiff::DualNum)}
        dual_args = args.map(&:to_dual)
        self.public_send(dual_meth, *dual_args)
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
      r = sin(n.real)
      e = cos(n.real) * n.epsilon
      Autodiff::DualNum.new(r, e)
    end

    dual_method(:cos)
    def dual_cos(n)
      r = cos(n.real)
      e = -sin(n.real) * n.epsilon
      Autodiff::DualNum.new(r, e)
    end

  end
end
