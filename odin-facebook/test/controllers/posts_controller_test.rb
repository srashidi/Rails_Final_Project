require 'test_helper'

class PostsControllerTest < ActionController::TestCase

	def setup
		@user = users(:shaunty)
	end

	test "should get index" do
  	sign_in @user
    get :index
    assert_response :success
  end
end
