describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}


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

end
