require 'active_support/core_ext/module/delegation'
module RedBikini

  def self.add_to_wardrobe! klass=Object
    klass.module_exec do
      def in_public &block
        ::RedBikini::Make.in_public(self,&block)
      end
      alias in_bikini in_public
      def expose &block
        ::RedBikini::Make.expose(self,&block)
      end
      alias tell expose
      alias confide expose
    end

    klass.instance_exec do
      def such_that *args, &description
        ::RedBikini::Make.in_public(new(*args),&description)
      end
    end

  end

  module Make
    module_function
    def in_public receiver, &block
      expose(receiver, &block)
      receiver
    end
    def expose receiver, &block
      Bikini.new(receiver).instance_exec &block
    end
  end

  class Bikini
    def initialize object
      @object = object
    end
    delegate :is_a?, :kind_of?, :===, :class, to: :@object

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


