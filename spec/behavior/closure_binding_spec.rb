describe RedBikini, 'closure stuff'  do

  before{RedBikini.add_to_wardrobe! Person}

  let(:joe){Person.new(1,'Joe')}
  example{name = 'Local Joe'; expect(joe.tell{name}).to eq 'Local Joe'}
  context 'there is caller method with same name' do
    let(:name){'Host Joe'}
    specify{expect(joe.tell{name}).to eq 'Joe'}
  end
  context do
    HOST_CONST = 'Joe is best'
    specify{expect(joe.tell{HOST_CONST}).to eq 'Joe is best'}
  end
  specify 'Host const shadows own with same name', :gotcha do
    stub_const 'OWN_CONST', 'Shadowing person const'
    (expect joe.tell{OWN_CONST}).to eq 'Shadowing person const'
  end
  specify{expect(joe.tell{OWN_CONST}).to eq 'Person const'}

end
