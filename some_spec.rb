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
    specify{expect(a_person.tell{self}).to be_a Person}
    specify{expect(a_person.tell{Person === self}).to be_true}
    specify{expect(a_person.tell{self === Person}).to be_true}
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
    specify{expect(joe.tell{OWN_CONST}).to eq 'Person const'}
  end

  describe do
    example{expect(Person.new(1,'Jack').in_public{name ||= 'George'}.name).to eq 'Jack'}
    example{expect(Person.new(1,nil).in_public{name ||= 'George'}.name).to eq nil}
    example{expect(Person.new(1,nil).in_public{self.name ||= 'George'}.name).to eq 'George'}
    example{expect(Person.new(1,nil).in_public{name_is name || 'George'}.name).to eq 'George'}
  end
end
