[![Build Status](https://travis-ci.org/idrozd/red_bikini.png?branch=master)](https://travis-ci.org/idrozd/red_bikini)

# What is this?
Something you come up with when you know a little ruby and words `public_exec` stuck in your head for a couple days:
`instance_exec` on wrapper around receiver to conceal private methods, with aliased setters

### cat spec/show_off_spec.rb
```ruby
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
      .to raise_error NoMethodError # private
    end
    specify do
      expect{josephine.expose{girly_secrets}}
      .to raise_error NoMethodError # protected
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

```
### cat spec/person.rb
```ruby
  Person = Struct.new(:id, :name, :friends, :nickname) do
    OWN_CONST = 'Person const'
    def === other
      other.respond_to? :id and id == other.id
    end
    private
    def credit_card_number
      'meh'
    end
    protected
    def girly_secrets
      'nah'
    end
  end

```

### Red Bikini?
Red for ruby, bikini for informal communication
Think of objects in bikini

### Why?
It just would not let me go

### So...
You probably shouldn't use this for serious things, but I wouldn't discourage you from it of course.
Some kind of DSL sounds as a candidate topic.

I would note that inside it uses instance exec applied to a wrapper around
reciever, so it wouldn`t bind calling context methods (which is good), 
but binds locals and constants.
- Also, or/equal (`||=`) won't work directly without specifiyng explicit receiver of course (`self.attr ||=` will work)
- Also, `self` wouldn't work with `case` operator - I don't want to hack reciever class `.===` just for that.
Although, you may use `_self` for this (original object).

### rspec --tag gotcha --format documentation
Run options: include {:gotcha=>true}

RedBikini
  closure stuff
    Host const shadows own with same name

RedBikini operators
  {attr ||= val} will create block-local var shadowing attr

RedBikini
  hacked typing
    ClassInBikini === self # => false

Finished in 0.00359 seconds
3 examples, 0 failures


[Detailed behavior](spec/behavior)
