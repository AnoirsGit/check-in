require "test_helper"

class WorkingTimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @working_time = working_times(:one)
  end

  test "should get index" do
    get working_times_url
    assert_response :success
  end

  test "should get new" do
    get new_working_time_url
    assert_response :success
  end

  test "should create working_time" do
    assert_difference('WorkingTime.count') do
      post working_times_url, params: { working_time: { bio: @working_time.bio, ended_at: @working_time.ended_at, started_at: @working_time.started_at, user_id: @working_time.user_id } }
    end

    assert_redirected_to working_time_url(WorkingTime.last)
  end

  test "should show working_time" do
    get working_time_url(@working_time)
    assert_response :success
  end

  test "should get edit" do
    get edit_working_time_url(@working_time)
    assert_response :success
  end

  test "should update working_time" do
    patch working_time_url(@working_time), params: { working_time: { bio: @working_time.bio, ended_at: @working_time.ended_at, started_at: @working_time.started_at, user_id: @working_time.user_id } }
    assert_redirected_to working_time_url(@working_time)
  end

  test "should destroy working_time" do
    assert_difference('WorkingTime.count', -1) do
      delete working_time_url(@working_time)
    end

    assert_redirected_to working_times_url
  end
end
