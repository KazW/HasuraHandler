require 'test_helper'

module HasuraHandler
  class ActionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should post process" do
      post actions_process_url
      assert_response :success
    end

  end
end
