class ReportUser < ActiveRecord::Base

belongs_to :user, foreign_key: :reporter_id
	belongs_to :friend , :class_name => 'User', foreign_key: :reported_id


end
