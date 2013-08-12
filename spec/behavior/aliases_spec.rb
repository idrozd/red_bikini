describe RedBikini, 'aliases' do
  before {RedBikini.add_to_wardrobe! Person}

  example do
    patrick = Person.new(1,'Patrick')

    [
      patrick.expose{"I'm #{name}"},
      patrick.tell{"I'm #{name}"},
      patrick.confide{"I'm #{name}"},
      "I'm Patrick"
    ].uniq.should have(1).string
  end


  example '#in_public and #in_bikini are just tap expose' do
    [
      Person.new.in_public{nickname_is 'Dredd'},
      Person.new.in_bikini{set_nickname 'Dredd'},
      Person.new(nil,nil,nil,'Dredd')
    ].uniq.should have(1).element
  end
end
