require 'test_helper'

class LikeideaTest < ActiveSupport::TestCase

	  def test_valid_like_idea
  	likeidea= likeideas(:complete_likeidea)
  	assert likeidea.valid?
  end

  def test_missing_user
  	likeidea = likeideas(:no_user)
  	assert !likeidea.valid?
  end

   def test_missing_idea
  	likeidea = likeideas(:no_idea)
  	assert !likeidea.valid?
  end

  def test_duplicates
  	likeidea1 = likeideas(:complete_likeidea)
    duplicate = likeidea1.dup
    assert !duplicate.valid?
  end
end
