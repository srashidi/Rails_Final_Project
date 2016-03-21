require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase

	def setup
		@user = users(:shaunty)
	end

  test "should get show" do
  	sign_in @user
    get :show
    assert_response :success
  end
end
