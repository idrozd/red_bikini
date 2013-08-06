require_relative 'code'

describe RedBikini do
  Person = Struct.new(:id, :name, :friends, :mood) do
    def im_a_girl! traits
      self.name = traits.fetch :name
      self.mood = traits.fetch :mood
    end
  end

  before{RedBikini.add_to_wardrobe! Person}


  specify do
    individual = Person.new.tap do |individual|
      individual.id = 0b101_010
      individual.name = 'Frank'
      individual.friends = ['Susan', 'Rajesh']
      individual.mood    = :good
    end

    frank = Person.new.in_bikini do
      id_is 42
      name_is 'Frank'
      friends_are %w[Susan Rajesh]
      set_mood :good
    end

    expect(frank).to eq individual

    individual.tap do |individual|
      individual.im_a_girl! name: 'Josephine', mood: :bad
    end

    frank.in_public{ im_a_girl! name: 'Josephine', mood: :bad}

    expect(frank).to eq individual
  end




end
