class CreateProjectVolunteers < ActiveRecord::Migration
  def self.up
    create_table :project_volunteers do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :role

      t.timestamps
    end
    
    add_index :project_volunteers, :user_id
    add_index :project_volunteers, :project_id
  
  end

  def self.down
    remove_index :project_volunteers, :user_id
    remove_index :project_volunteers, :project_id

    drop_table :project_volunteers
  end
end