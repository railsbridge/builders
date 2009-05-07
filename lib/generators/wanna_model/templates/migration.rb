class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %> do |t|
<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
<% unless options[:skip_timestamps] %>
      t.timestamps
<% end -%>
    end
    
<% attributes.select(&:reference?).each do |attribute| -%>
    add_index :<%= table_name %>, :<%= attribute.name %>_id
<% end -%>  
  end

  def self.down
<% attributes.select(&:reference?).each do |attribute| -%>
    remove_index :<%= table_name %>, :<%= attribute.name %>_id
<% end %>
    drop_table :<%= table_name %>
  end
end