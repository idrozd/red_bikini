describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}

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
    specify{expect(a_person.tell{self === Person.new(1)}).to be_true}
    specify{RedBikini.add_to_wardrobe! Class; expect(Fixnum.tell{self === 1}).to be_true}
  end
end
