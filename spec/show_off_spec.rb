describe RedBikini do

  before{RedBikini.add_to_wardrobe! Person}

  example 'punchline', contrived: true do
    time = '17:00'

    expect("Tom, Gia and 'Happy' Mike are heading to the cinema at 17:00").to eq(
      Person.such_that do
        name_is 'Mike'
        friends_are %w[Tom Gia]
        set_nickname 'Happy'
      end.confide('the cinema') do |where|
        "#{friends * ', '} and '#{nickname}' #{name} are heading to #{where} at #{time}"
      end
    )

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

end
