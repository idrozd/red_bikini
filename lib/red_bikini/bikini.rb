require 'forwardable'
class RedBikini::Bikini
  extend ::Forwardable


  def initialize object
    @__in_bikini__ = object
  end

  def === other
    @__in_bikini__ === other
  end

  def _self
    @__in_bikini__
  end

  def object_method method
    original(method) or setter_imitated_by(method)
  end
  def original method
    @__in_bikini__.respond_to?(method, true) and method
  end

  def respond_to_missing? method, *args
    @__in_bikini__.respond_to?(object_method(method), *args)
  end
  def method_missing method, *args
    @__in_bikini__.public_send(object_method(method), *args)
  end


  def setter_imitated_by method
    [/set_(?<attr>\w+)/,/(?<attr>\w+)(_are|_is)/].find do |setter_matcher|
      String(method).match(setter_matcher){|match| return match['attr'] + ?= }
    end
  end

  def_delegators :@__in_bikini__, :is_a?, :kind_of?, :instance_of?, :class


end
