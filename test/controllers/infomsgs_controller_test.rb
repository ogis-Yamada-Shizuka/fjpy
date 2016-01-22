require 'test_helper'

class InfomsgsControllerTest < ActionController::TestCase
  setup do
    @infomsg = infomsgs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infomsgs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infomsg" do
    assert_difference('Infomsg.count') do
      post :create, infomsg: { description: @infomsg.description, effective_date: @infomsg.effective_date, title: @infomsg.title }
    end

    assert_redirected_to infomsg_path(assigns(:infomsg))
  end

  test "should show infomsg" do
    get :show, id: @infomsg
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @infomsg
    assert_response :success
  end

  test "should update infomsg" do
    patch :update, id: @infomsg, infomsg: { description: @infomsg.description, effective_date: @infomsg.effective_date, title: @infomsg.title }
    assert_redirected_to infomsg_path(assigns(:infomsg))
  end

  test "should destroy infomsg" do
    assert_difference('Infomsg.count', -1) do
      delete :destroy, id: @infomsg
    end

    assert_redirected_to infomsgs_path
  end
end
