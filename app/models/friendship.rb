<<<<<<< HEAD
class Friendship < ActiveRecord::Base



	belongs_to :user
	belongs_to :friend , :class_name => 'User'


	
	
end
=======
class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend , :class_name => 'User'
end
>>>>>>> 4bd781fbe16a9f87e2099cdf7436c80c51d7c5a7
