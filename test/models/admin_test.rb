require 'test_helper'

class AdminTest < ActiveSupport::TestCase
   
   # This test just makes sure that there is no repeated record
   # in the table namd "admins"
   test "repeated record" do
     admin = admins(:repeated_record_in_admins_table)
     assert !admin.valid?
   end
end
