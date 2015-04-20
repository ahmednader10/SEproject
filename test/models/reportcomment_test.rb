require 'test_helper'

class ReportcommentTest < ActiveSupport::TestCase

  def test_valid_report_comment
  	 reportcomment = reportcomments(:complete_reportcomment)
  	 assert reportcomment.valid?
  end

  def test_missing_user
  	reportcomment = reportcomments(:no_user)
  	assert !reportcomment.valid?
  end

   def test_missing_comment
  	reportcomment= reportcomments(:no_comment)
  	assert !reportcomment.valid?
  end

  def test_duplicates
  	reportcomment1 = reportcomments(:complete_reportcomment)
    duplicate = reportcomment1.dup
    assert !duplicate.valid?
  end
end
