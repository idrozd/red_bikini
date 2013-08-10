module RedBikini
  require_relative 'red_bikini/bikini'

  def self.add_to_wardrobe! klass=Object
    klass.send :include, InstanceMethods
    klass.send :extend,  ClassMethods
  end

  ExecuteInWrappedContext = ->(receiver, args, block) do
    Bikini.new(receiver).instance_exec *args, &block
  end

  module InstanceMethods
    def in_public *args, &block
      tap{self.expose *args, &block}
    end
    alias in_bikini in_public
    def expose *args, &block
      ExecuteInWrappedContext.call self, args, block
    end
    alias tell expose
    alias confide expose
  end


  module ClassMethods
    def such_that *args, &description
      new(*args).in_public &description
    end
  end


  ::Kernel.module_exec do
    def which &block
      proc{|receiver|receiver.expose &block}
    end
  end

end


