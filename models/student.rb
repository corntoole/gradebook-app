class Student < ActiveRecord::Base
	self.table_name = 'students'
	self.primary_key = :id

	has_many :courses, through: :courses_has_students
end