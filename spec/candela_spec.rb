# frozen_string_literal: true

RSpec.describe Candela do
  it "has a version number" do
    expect(Candela::VERSION).not_to be nil
  end

  describe Candela::Tensor do
    it "can create a tensor" do
      tensor = Candela::Tensor.new([1.0, 2.0, 3.0, 4.0], [2, 2])
      expect(tensor).to be_a(Candela::Tensor)
    end

    it "can get the shape of a tensor" do
      tensor = Candela::Tensor.new([1.0, 2.0, 3.0, 4.0], [2, 2])
      expect(tensor.shape).to eq([2, 2])
    end

    it "can convert a tensor to a vector" do
      tensor = Candela::Tensor.new([1.0, 2.0, 3.0, 4.0], [2, 2])
      expect(tensor.to_vec).to eq([1.0, 2.0, 3.0, 4.0])
    end
  end
end
