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
    def initialize
      @blocks = {}
    end
    
    def load code
      self.instance_eval code
    end

    def blocks
      @blocks
    end
    
    def create_context *attrs
      o = Object.new
      attrs.each do |attr|
        o.class.send :attr_accessor, attr
      end
      o 
    end
    
    def execute_in_context ctx, category, event
      b = @blocks[category][event]
      ctx.instance_eval &b
    end
    
    private

    def on name, &block
      puts "In on method: #{block.inspect}"
      @blocks[:on] ||= {}
      @blocks[:on][name] = block
    end

  end
  
end
