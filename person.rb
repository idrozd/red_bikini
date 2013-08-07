  Person = Struct.new(:id, :name, :friends, :mood) do
    def im_a_girl! traits
      self.name = traits.fetch :name
      self.mood = traits.fetch :mood
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
