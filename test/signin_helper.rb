require "test_helper"
require "capybara/rails"
require 'capybara-webkit'
require 'minitest/autorun'

module SigninHelper
  def signin( user )
    # 
    # User03でログイン
    # 
    visit '/'
    
    # ログイン画面が表示されたことを確認
    assert_content 'ログイン'
    
    # ユーザＩＤとパスワードを入力
    # fill_in 'user_userid',   with: 'user02'
    fill_in 'user_userid',   with: user
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'

    # ログインに成功したことを検証する
    assert_content 'ログインしました'
    assert_content 'メニュー'

  end
end
