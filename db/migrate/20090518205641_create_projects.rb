class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string  :org_name
      t.text    :org_details
      t.string  :contact_name
      t.string  :contact_phone
      t.string  :contact_email
      t.string  :website
      t.text    :description
      t.boolean :approved
      t.string  :access_key
      t.timestamps
    end
    
  
  end

  def self.down

    drop_table :projects
  end
end
