require "test_helper"

feature "Login" do
  scenario "user03 has logged in" do
    visit root_path
    page.must_have_content "ログイン"
 
    # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User03'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'
    # ログインに成功したことを検証する
    page.must_have_content 'ログインしました'
  end
end
