require "test_helper"

feature "NewEquipment" do
  scenario "user03 creates a new equpment" do
    visit root_path
    page.must_have_content "ログイン"
    # page.must_have_content "commit"
 
    # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User01'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'
    # ログインに成功したことを検証する
    page.must_have_content 'ログインしました'
  end
end