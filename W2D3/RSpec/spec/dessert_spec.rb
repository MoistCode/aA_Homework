require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) {Dessert.new('brownie', 10, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq('brownie')
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new('brownie', 'ten', chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient('baking powder')
      expect(dessert.ingredients).to include('baking powder')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient('baking powder')
      dessert.add_ingredient('oranges')
      dessert.add_ingredient('banana peels')
      dessert.add_ingredient('coca cola')
      expect(dessert.mix!).to_not eq(['baking powder', 'oranges', 'banana peels', 'coca cola'])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(5)
      expect(dessert.quantity).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(1000)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef")
      allow(dessert.type).to receive(:pluralize).and_return("brownies")
      expect(dessert.serve).to eq("Chef has made 10 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end