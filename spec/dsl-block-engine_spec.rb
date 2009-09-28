require File.dirname(__FILE__) + '/spec_helper.rb'

describe DslBlockEngine do
  
  before do
    @engine = DslBlockEngine::DslBlockEngine.new 
  end
  
  it "should load named blocks" do
    code = %q{
      on :event1 do
      end

      on :event2 do
      end
    }
    
    @engine.categories = [:on]
    @engine.load code
    @engine.blocks[:on].size.should == 2
  end

  it "should provide properties accessible for the block" do
    code = %q{
      on :event1 do
        a + b
      end
    }

    @engine.categories = [:on]
    @engine.load code
    context = @engine.create_context :a, :b
    
    context.a = 2
    context.b = 4
    
    result = @engine.execute_in_context context, :on, :event1
    result.should == 6
  end

  it "should support different names for the categories" do
    code = %q{
      at :event1 do
        8
      end
    }

    @engine.categories = [:at]
    @engine.load code
    @engine.blocks[:at].size.should == 1
  end
end

