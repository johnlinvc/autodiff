module Autodiff

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

  class DualNum < Numeric
    attr :real, :epsilon
    def initialize(n, e=0)
      @real = n
      @epsilon = e
      self.freeze
    end

    def to_dual
      self
    end

    def to_one_epsilon
      Autodiff::DualNum.new(self.real, 1)
    end

    def +(other)
      r = @real + other.real
      e = @epsilon + other.epsilon
      self.class.new(r, e)
    end

    def -(other)
      r = @real - other.real
      e = @epsilon - other.epsilon
      self.class.new(r, e)
    end

    def *(other)
      r = @real * other.real
      e = @real * other.epsilon + @epsilon * other.real
      self.class.new(r, e)
    end

    def to_float
      real
    end

  end

end

class Numeric

  def real
    self
  end

  def epsilon
    0
  end

  def to_dual
    Autodiff::DualNum.new(self)
  end

end

