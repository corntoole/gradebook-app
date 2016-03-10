class Assignemnt < ActiveRecord::Base
	self.table_name = 'assignments'
	self.primary_key = :id

	has_many :courses, through: :assignments_has_courses
	has_one :grade_categories
	belongs_to :graded_activities
end