module Autodiff

  class DualNum < Numeric
    attr :real, :epsilon
    def initialize(n, e=0)
      @real = n
      @epsilon = e
    end

    def to_dual
      self
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
