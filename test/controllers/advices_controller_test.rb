require 'test_helper'

class AdvicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advice = advices(:one)
  end

  test "should get index" do
    get advices_url
    assert_response :success
  end

  test "should get new" do
    get new_advice_url
    assert_response :success
  end

  test "should create advice" do
    assert_difference('Advice.count') do
      post advices_url, params: { advice: {  } }
    end

    assert_redirected_to advice_url(Advice.last)
  end

  test "should show advice" do
    get advice_url(@advice)
    assert_response :success
  end

  test "should get edit" do
    get edit_advice_url(@advice)
    assert_response :success
  end

  test "should update advice" do
    patch advice_url(@advice), params: { advice: {  } }
    assert_redirected_to advice_url(@advice)
  end

  test "should destroy advice" do
    assert_difference('Advice.count', -1) do
      delete advice_url(@advice)
    end

    assert_redirected_to advices_url
  end
end
