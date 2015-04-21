require 'test_helper'

class ReportcommentTest < ActiveSupport::TestCase

#check that report comment has all the required data to be valid
  def test_valid_report_comment
  	 reportcomment = reportcomments(:complete_reportcomment)
  	 assert reportcomment.valid?
  end
#checks that reportcommnet is not valid if userid doesnt exist
  def test_missing_user
  	reportcomment = reportcomments(:no_user)
  	assert !reportcomment.valid?
  end

#checks that reportcommnet is not valid if commentid doesnt exist   
  def test_missing_comment
  	reportcomment= reportcomments(:no_comment)
  	assert !reportcomment.valid?
  end
#checks that no duplicates occur
  def test_duplicates
  	reportcomment1 = reportcomments(:complete_reportcomment)
    duplicate = reportcomment1.dup
    assert !duplicate.valid?
  end
end
