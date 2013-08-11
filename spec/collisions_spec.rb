describe RedBikini, 'name collisions' do
  example do
    Battlecruiser = Class.new do
      attr_accessor :captain_has_parrot, :the_course
      def set_the_course where
        "Course is set! Heading #{where}"
      end
    end

    RedBikini.add_to_wardrobe! Battlecruiser

    battlecruiser = Battlecruiser.such_that do
      set_the_course 'nowhere'
      captain_has_parrot_is true
    end

    battlecruiser.the_course.should be_nil
    battlecruiser.captain_has_parrot.should eq true
  end
end
