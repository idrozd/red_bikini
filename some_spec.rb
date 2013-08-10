require_relative 'code'
require_relative 'person'

describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}

  example 'punchline', contrived: true do
    expect(Person.such_that do
        name_is 'Luce'
        friends_are %w[Tom Gia]
        set_nickname 'Happy'
      end.confide('the cinema') do |where|
        "#{friends * ', '} and '#{nickname}' #{name} are heading to #{where}"
      end).to eq \
    "Tom, Gia and 'Happy' Luce are heading to the cinema"
  end

  describe 'Kernel#which' do
    example :even_more_contrived do
      [Person.new(nil, 'George'),
       Person.new(nil, 'Kevin' ),
       Person.new(nil, 'Steven'),
       Person.new(22)].

      find_all(&which{name and name =~ /ev/}).

      map(&:name).
      should eq %w[Kevin Steven]
    end
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
    specify :gotcha do
      expect(a_person.tell{Person === self}).to be_false

      expect(a_person.tell{Person === _self}).to be_true
      expect(a_person.tell{Person === @__in_bikini__}).to be_true
    end
    specify{expect(a_person.tell{self === Person}).to be_false} # As expected
    specify{expect(a_person.tell{self === Person.new(1)}).to be_true} # As expected
    specify{RedBikini.add_to_wardrobe! Class; expect(Fixnum.tell{self === 1}).to be_true}
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
