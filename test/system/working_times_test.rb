require "application_system_test_case"

class WorkingTimesTest < ApplicationSystemTestCase
  setup do
    @working_time = working_times(:one)
  end

  test "visiting the index" do
    visit working_times_url
    assert_selector "h1", text: "Working Times"
  end

  test "creating a Working time" do
    visit working_times_url
    click_on "New Working Time"

    fill_in "Bio", with: @working_time.bio
    fill_in "Ended at", with: @working_time.ended_at
    fill_in "Started at", with: @working_time.started_at
    fill_in "User", with: @working_time.user_id
    click_on "Create Working time"

    assert_text "Working time was successfully created"
    click_on "Back"
  end

  test "updating a Working time" do
    visit working_times_url
    click_on "Edit", match: :first

    fill_in "Bio", with: @working_time.bio
    fill_in "Ended at", with: @working_time.ended_at
    fill_in "Started at", with: @working_time.started_at
    fill_in "User", with: @working_time.user_id
    click_on "Update Working time"

    assert_text "Working time was successfully updated"
    click_on "Back"
  end

  test "destroying a Working time" do
    visit working_times_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Working time was successfully destroyed"
  end
end
