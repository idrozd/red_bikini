class Representer
  def initialize elector
    @Elector = elector
  end
  def respond_to_missing? method, *args
    @elector.respond_to? method, *args
  end
  def method_missing method, *args
    pp method, *args
    @elector.public_send method, *args
  end

  def self.elect
    Object.module_exec do
      def says_loud &speech
        Representer.new(self).instance_exec &speech
      end
    end
  end
end


class Electorat
  def people_needs what=nil
    %w[food entertainment]
  end
end

describe Representer do
  Representer.elect

  let(:representer){described_class.new Electorat.new}
  let(:joe){Electorat.new}

  it 'clearly states what he`s people want' do
    allow(joe).to receive(:people_needs)
    joe.says_loud do
      people_needs :are_overrated
    end

    expect(joe).to have_received(:people_needs).with :are_overrated
  end


  #it 'does not tell secrets' do

    #expect do
      #joe.says_loud do
        #fuck_mukuckn! :definetely
      #end
    #end.not_to raise_error NoMethodError

  #end



  specify do
    expect(representer).to respond_to :people_needs
  end
  specify do
    expect(representer.people_needs).to eq %w[food entertainment]
  end

end

