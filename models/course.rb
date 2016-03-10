class Course < ActiveRecord::Base
	self.table_name = 'courses'
	self.primary_key = :id

	has_many :students, through: :courses_has_students	
	has_many :assignments, through: :assignments_has_courses
end
