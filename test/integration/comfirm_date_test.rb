# key in command below to run
# rake test TEST='test/integration/comfirm_date_test.rb'
require "test_helper"
require "integration_test_helper"
require "capybara/rails"
require 'rails/test_help'
require 'headless'

class ComfirmDateTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules

  def test_comfirm_date
    # ---------------------------------------------------
    # 拠点ユーザーが点検予定を確定する
    # ---------------------------------------------------

    # 2.a User02でログイン
    visit '/'

   # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User02'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'

    # ログインに成功したことを検証する
    assert_content 'ログインしました'
    assert_content 'メニュー'
    assert_content '大阪第１'
    assert_content '村山音々'

    # 1.b メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）装置システム一覧リンクをクリックする
    click_link '候補日回答済一覧', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '年月'
    assert_content '対象装置システム'
    assert_content '設置場所'
    assert_content '担当サービス会社'
  
    # 2.c
    # テーブルの中の名称「」の行の候補日時回答リンクをクリック
    find(:xpath, "//tr[td[contains(.,'S010-003')]]/td/a", :text => '日程確定').click
      
    # 候補日回答画面に遷移したことを確認
    assert_content '日程確定'
    assert_content '点検予定日時メモ  '

    # 確定日やメモを入力する
    fill_in '点検予定日時', with: Date.new(2016, 4, 20)
    fill_in '点検予定日時メモ', with: '午前中をご希望です'
    fill_in 'アポ担当者(YES拠点)', with: '小山田'
    fill_in 'アポ担当者(顧客)', with: '大山田様'
    
    # 登録ボタンをクリック
    click_button '更新する'

    # 点検依頼が登録されたことを確認する。
    assert_content '点検予定の確認'
    assert_content 'InspectionSchedule was successfully updated.'
    assert_content 'S010-003'
    assert_content '点検依頼済'
    assert_content '点検予定日時:'
    assert_content '午前中をご希望です'
    assert_content '小山田'
    assert_content '大山田様'
    
    click_link 'Back'

  end
end