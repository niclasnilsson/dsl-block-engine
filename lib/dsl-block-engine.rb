$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module DslBlockEngine
  VERSION = '0.0.4'

  class Context
    def attr_accessor *names
      names.each do |name|
        self.class.send :attr_accessor, name
      end
    end
  end
  
  class DslBlockEngine
    attr_accessor :categories

    def initialize
      @blocks = {}
      @categories = []
    end
    
    def load code
      self.instance_eval code
    end

    def blocks
      @blocks
    end

    def create_context *attrs
      o = Object.new

      def o.add_attribute name
        self.class.send :attr_accessor, name
      end

      attrs.each do |attr|
        o.add_attribute attr
      end
      
      o
    end

    def execute_in_context ctx, category, event
      b = @blocks[category][event]
      ctx.instance_eval &b
    end

    def method_missing name, *args, &block
      category = name
      event = args[0]
      super.method_missing(name, args, &block) unless @categories.include? category
      @blocks[category] ||= {}
      @blocks[category][event] = block
    end

  end
  
end
