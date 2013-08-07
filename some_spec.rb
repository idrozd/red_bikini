require_relative 'code'
require_relative 'person'

describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}

  example do
    expect(Person.such_that do
        name_is 'Luce'
        friends_are %w[Tom Gia]
        set_mood :happy
      end.confide do
        "#{name} is very #{mood} about #{friends * ' and '} being his friends"
      end).to eq \
    "Luce is very happy about Tom and Gia being his friends"
  end

  specify do
    individual = Person.new.tap do |individual|
      individual.id = 0b101_010
      individual.name = 'Frank'
      individual.friends = ['Susan', 'Rajesh']
      individual.mood    = :good
    end

    frank = Person.such_that do
      id_is 42
      name_is 'Frank'
      friends_are %w[Susan Rajesh]
      set_mood :good
    end

    expect(frank).to eq individual

    individual.tap do |individual|
      individual.im_a_girl! name: 'Josephine', mood: :bad
    end

    frank.in_public{im_a_girl! name: 'Josephine', mood: :bad}

    expect(frank).to eq individual
  end


  specify 'confide,tell and expose return block result' do
    person = Person.such_that{name_is 'Daniel'; friends_are %w[Mary Steven]; mood_is :great}

    expect(person.tell{"#{name} and #{friends.join ' and '} are friends"})
    .to eq 'Daniel and Mary and Steven are friends'

    expect(person.confide{"I feel #{mood}!"}).to eq 'I feel great!'
  end


  describe 'access' do
    let(:josephine){ Person.new(1,'Josephine')}
    specify do
      expect{josephine.tell{credit_card_number}}
      .to raise_error(NoMethodError, /private/)
    end
    specify do
      expect{josephine.expose{girly_secrets}}
      .to raise_error NoMethodError, /protected/
    end
  end


  describe 'hacked typing' do
    let(:a_person){Person.new(1,'Joe')}
    specify{expect(a_person.tell{self.is_a? Person}).to be_true}
    specify{expect(a_person.tell{is_a? Person}).to be_true}
    specify{expect(a_person.tell{self.class}).to eq Person}
    specify{expect(a_person.tell{kind_of? Person}).to be_true}
  end

  describe 'closure stuff' do
    let(:joe){Person.new(1,'Joe')}
    HOST_CONST = 'Joe is best'
    example{name = 'Local Joe'; expect(joe.tell{name}).to eq 'Local Joe'}
    context 'there is caller method with same name' do
      let(:name){'Host Joe'}
      specify{expect(joe.tell{name}).to eq 'Joe'}
    end
    specify{expect(joe.tell{HOST_CONST}).to eq 'Joe is best'}
  end
end
