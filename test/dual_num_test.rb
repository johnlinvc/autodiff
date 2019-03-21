require "test_helper"

describe Autodiff::DualNum do
  let(:pure_real) {Autodiff::DualNum.new(42)}
  let(:dual) {Autodiff::DualNum.new(55, 66)}
  let(:dual2) {Autodiff::DualNum.new(77, 88)}

  describe ".new" do
    it "should able to have only real part" do
      pure_real.real.must_equal 42
      pure_real.epsilon.must_equal 0
    end
    it "should able to have both real and epsilon part" do
      dual.real.must_equal 55
      dual.epsilon.must_equal 66
    end
  end

  describe "#+" do

    it "should adds up the real part" do
      dd = dual + dual
      dd.real.must_equal(dual.real + dual.real)
    end

    it "should adds up the epsilon part" do
      dd = dual + dual
      dd.epsilon.must_equal(dual.epsilon + dual.epsilon)
    end

  end

  describe "#*" do

    it "should multiple the real part" do
      dd = dual * dual2
      dd.real.must_equal(dual.real * dual2.real)
    end

    it "should have the epsilon part as r1*e2 + r2*e1" do
      dd = dual * dual2
      dd.epsilon.must_equal(dual.real * dual2.epsilon + dual2.real * dual.epsilon)
    end

  end

end
