class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table(:courses, if_exists: false)  do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table(:courses, if_exists: true)
  end
end
