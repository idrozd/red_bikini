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
