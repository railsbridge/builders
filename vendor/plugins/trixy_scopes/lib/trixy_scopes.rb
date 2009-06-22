module TrixyScopes 

  # TODO
  # latest, earliest, random - limit should be optional

  def self.included(klass)
    klass.class_eval do
      return unless klass.table_exists?
      table_name = klass.quoted_table_name
      connection = ActiveRecord::Base.connection
      adapter    = connection.adapter_name
         
      named_scope :random, :order => adapter == "SQLite" ? "RANDOM()" : "RAND()"
      named_scope :order_by, lambda { |order| { :order => order} }
     
      named_scope :limit, lambda { |limit| { :limit => limit } }
      named_scope :latest, lambda { |limit| { :limit => limit, :order => "#{table_name}.`created_at` DESC" } } 
      named_scope :earliest, lambda { |limit| { :limit => limit, :order => "#{table_name}.`created_at` ASC" } }
      named_scope :before, lambda { |datetime| { :conditions => ["#{table_name}.`created_at` < ?", datetime] } }
      named_scope :after, lambda { |datetime| { :conditions => ["#{table_name}.`created_at` > ?", datetime] } }

      
      klass.columns.each do |column|
        attribute = column.name
        quoted_column_name = "#{connection.quote_table_name(klass.table_name)}.#{connection.quote_column_name(attribute)}"
        
        named_scope "#{attribute}_is", lambda { |value| { :conditions => { attribute => value } } }
        named_scope "#{attribute}_is_not", lambda { |value| { :conditions => ["#{quoted_column_name} != ?", value] } }
        named_scope "#{attribute}_is_nil", :conditions => { attribute => nil }
        named_scope "#{attribute}_is_not_nil", :conditions => "#{quoted_column_name} IS NOT NULL"
        
        named_scope "#{attribute.pluralize}_are", lambda { |*ids| { :conditions => { attribute => ids.flatten } } }
        named_scope "#{attribute.pluralize}_are_not", lambda { |*ids| { :conditions => ["#{quoted_column_name} NOT IN(?)", ids.flatten] } }
        
        unless column.type == :boolean
          named_scope "#{attribute}_between", lambda { |from, to| { :conditions => ["#{quoted_column_name} BETWEEN ? AND ?", from, to] } }
          named_scope "#{attribute}_not_between", lambda { |from, to| { :conditions => ["#{quoted_column_name} NOT BETWEEN ? AND ?", from, to] } }
        end
        
        unless column.type == :boolean || column.type == :text
          named_scope "#{attribute}_in", lambda { |*elements| { :conditions => { attribute => elements.flatten } } }
          named_scope "#{attribute}_not_in", lambda { |*elements| { :conditions => ["#{quoted_column_name} NOT IN(?)", elements.flatten] } }
        end
                
        if column.type == :datetime
          named_scope "#{attribute}_before", lambda { |datetime| { :conditions => ["#{quoted_column_name} < ?", datetime] } }
          named_scope "#{attribute}_after", lambda { |datetime| { :conditions => ["#{quoted_column_name} > ?", datetime] } }
          
          if attribute.last(3) == "_at"
            attribute_alias = attribute.chomp("_at")
            named_scope "#{attribute_alias}_between", lambda { |from, to| { :conditions => ["#{quoted_column_name} BETWEEN ? AND ?", from, to] } }
            named_scope "not_#{attribute_alias}_between", lambda { |from, to| { :conditions => ["#{quoted_column_name} NOT BETWEEN ? AND ?", from, to] } }
            named_scope "#{attribute_alias}_before", lambda { |datetime| { :conditions => ["#{quoted_column_name} < ?", datetime] } }
            named_scope "#{attribute_alias}_after", lambda { |datetime| { :conditions => ["#{quoted_column_name} > ?", datetime] } }
          end
        end
        
        if column.type == :integer || column.type == :float
          named_scope "#{attribute}_greater_than", lambda { |value| { :conditions => ["#{quoted_column_name} > ?", value] } }
          named_scope "#{attribute}_greater_or_equal_to", lambda { |value| { :conditions => ["#{quoted_column_name} >= ?", value] } }
          named_scope "#{attribute}_less_than", lambda { |value| { :conditions => ["#{quoted_column_name} < ?", value] } }
          named_scope "#{attribute}_less_or_equal_to", lambda { |value| { :conditions => ["#{quoted_column_name} <= ?", value] } }
        end
        
        if column.type == :string
          named_scope "#{attribute}_starts_with", lambda { |string| { :conditions => ["#{quoted_column_name} LIKE ?", "#{string}%"] } }
          named_scope "#{attribute}_ends_with", lambda { |string| { :conditions => ["#{quoted_column_name} LIKE ?", "%#{string}"] } }
          named_scope "#{attribute}_includes", lambda { |string| { :conditions => ["#{quoted_column_name} LIKE ?", "%#{string}%"] } }
          named_scope "#{attribute}_matches", lambda { |regexp| { :conditions => ["#{quoted_column_name} REGEXP ?", regexp] } }
        end
        
        if column.type == :text || column.type == :string
          named_scope "#{attribute}_like", lambda { |string| { :conditions => ["#{quoted_column_name} LIKE ?", string] } }
          named_scope "#{attribute}_not_like", lambda { |string| { :conditions => ["#{quoted_column_name} NOT LIKE ?", string] } }
        end
        
        if column.type == :boolean
          named_scope "#{attribute}", :conditions => { attribute => true }
          named_scope "not_#{attribute}", :conditions => { attribute => false }
        end
      end
      
    end
  end

end
