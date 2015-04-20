require 'test_helper'

class ReportideaTest < ActiveSupport::TestCase
  def test_valid_report_idea
  	 reportidea = reportideas(:complete_reportidea)
  	 assert reportidea.valid?
  end

  def test_missing_user
  	reportidea = reportideas(:no_user)
  	assert !reportidea.valid?
  end

   def test_missing_idea
  	reportidea = reportideas(:no_idea)
  	assert !reportidea.valid?
  end

  def test_duplicates
  	reportidea1 = reportideas(:complete_reportidea)
    duplicate = reportidea1.dup
    assert !duplicate.valid?
  end
end
