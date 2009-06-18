def should_be_taggable(*attributes)
  klass = model_class
  
  context "A #{klass.name}" do
    should "include the IsTaggable module" do
      assert klass.included_modules.include?(IsTaggable::TaggableMethods)
    end
    
    attributes.each do |a|
      should "accept tags on field #{a.inspect}" do
        assert klass.new.respond_to?("#{a.to_s.singularize}_list"), "does not accept tags on #{a.inspect}"
      end
    end    
  end  
end
