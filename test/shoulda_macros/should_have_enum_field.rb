def should_have_enum_field(name, *values)
  klass = model_class

  context "A #{klass.name}" do
    const_name = name.to_s.pluralize.upcase
    should "define constant #{const_name}" do
      assert klass.const_defined?(const_name)
    end
    
    should_have_db_column name
    
    if values.any?

        values.each do |value|
          should "allow #{value} as a possible value" do
           assert_contains klass.const_get(const_name), value
          end
        end
    end
  end
end
