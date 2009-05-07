Factory.define :<%= file_name %> do |factory|
<% for attribute in attributes -%>
  <%= factory_line(attribute) %>
<% end -%>
end