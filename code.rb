module RedBikini

  def self.add_to_wardrobe! el_class=Object
    el_class.module_exec do
      def in_public &speech
        tap{Bikini.new(self).instance_exec &speech}
      end
      alias in_bikini in_public
    end

  end

  class Bikini
    def initialize object
      @object = object
    end
    def object_method method
      setter_imitated_by(method) or method
    end
    def respond_to_missing? method, *args
      @object.respond_to?(object_method(method), *args)
    end
    def method_missing method, *args
      @object.public_send(object_method(method), *args)
    end

    def setter_imitated_by method
      [/set_(?<attr>\w+)/,/(?<attr>\w+)(_are|_is)/].find do |setter_matcher|
        String(method).match(setter_matcher){|match| return match['attr'] + ?= }
      end
    end
  end
end


