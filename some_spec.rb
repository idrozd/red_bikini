require_relative 'code'

describe RedBikini do
  Person = Struct.new(:id, :name, :friends)

  before{RedBikini.add_to_wardrobe! Person}


  specify do
    individual = Person.new.tap do |individual|
      individual.id = 0b101_010
      individual.name = 'Frank'
      individual.friends = ['Susan', 'Rajesh']
    end

    frank = Person.new.in_bikini do
      id_is 42
      name_is 'Frank'
      friends_are %w[Susan Rajesh]
    end

    expect(frank).to eq individual
  end


end
