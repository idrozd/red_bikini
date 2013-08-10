describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}


  describe do
    example{expect(Person.new(1,'Jack').in_public{name ||= 'George'}.name).to eq 'Jack'}
    example{expect(Person.new(1,nil).in_public{name ||= 'George'}.name).to eq nil}
    example{expect(Person.new(1,nil).in_public{self.name ||= 'George'}.name).to eq 'George'}
    example{expect(Person.new(1,nil).in_public{name_is name || 'George'}.name).to eq 'George'}
    # ... and so on. You`ve got the point
  end
end
