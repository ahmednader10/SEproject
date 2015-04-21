require 'test_helper'

class LikeideaTest < ActiveSupport::TestCase
#check that like idea has all the required data to be valid
	  def test_valid_like_idea
  	likeidea= likeideas(:complete_likeidea)
  	assert likeidea.valid?
  end

#checks that reportidea is not valid if userid doesnt exist
  def test_missing_user
  	likeidea = likeideas(:no_user)
  	assert !likeidea.valid?
  end

#checks that reportidea is not valid if ideaid doesnt exist
   def test_missing_idea
  	likeidea = likeideas(:no_idea)
  	assert !likeidea.valid?
  end

#checks that no duplicates occur
  def test_duplicates
  	likeidea1 = likeideas(:complete_likeidea)
    duplicate = likeidea1.dup
    assert !duplicate.valid?
  end
end
