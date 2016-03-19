# key in command below to run
# rake test TEST='test/integration/save_inspection_result_test.rb'
require "test_helper"
require "integration_test_helper"
require "capybara/rails"
require 'rails/test_help'
require 'headless'

class SaveInspectionResultTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules

  def test_save_inspection_result
    # ---------------------------------------------------
    # サービス会社ユーザーが点検予定に対して点検結果を登録する。
    # ---------------------------------------------------

    # テスト対象シリアルNo.
    serial_no = "S010-040"
    
    # User06でログイン
    # メニュー画面に遷移（セッションがないのでログイン画面が表示されるはず）
    visit '/'
    
    # ログイン画面が表示されたことを確認
    assert_content 'ログイン'
    
    # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User06'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'

    # ログインに成功したことを検証する
    assert_content 'ログインしました'
    assert_content 'メニュー'
    assert_content 'なにわサービス'
    assert_content '平良朱里'
    
    # メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの ）点検依頼一覧リンクをクリックする
    click_link '点検作業対象一覧', {match: :first, exact: true}
    
    # 点検依頼一覧のみに遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '点検作業対象一覧'
    assert_content '作業確定日時'
    assert_content '型式'
    assert_content 'シリアルNo.'
    assert_content '設置場所'
  
    # テーブルの中の該当シリアルNoの行の候補日時回答リンクをクリック
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '点検実施').click    

    # 候補日回答画面に遷移したことを確認
    assert_content '点検実施'
    
    # チェック結果タグをクリックする
    click_link 'チェック結果'
    # 天候、外観、色、汚れの入力
    select  '雪', from: '天候'
    select  '優', from: '外観'
    select  '良', from: '色'
    select  '可', from: '汚れ'

    # チェック結果タグをクリックする
    click_link '計測結果'
    # 各種数値の入力
    fill_in 'メーター値', with: 256
    fill_in 'テスター計測値', with: '512A'
    fill_in '評価点', with: 128

    # チェック結果タグをクリックする
    click_link 'その他点検実績'
    
    fill_in '所感', with: '大きな問題なし'
    
    # 点検実績登録ボタンをクリック
    click_button '点検実績登録'

    # 点検実績の確認画面が表示されることを確認
    assert_content 'InspectionResult was successfully created.'
    assert_content '点検実績の確認'
    # 登録した点検結果が表示されていることを確認
    assert_content '天候: 雪'
    assert_content 'Exterior: 優'
    assert_content 'Tone: 良'
    assert_content 'Stain: 可'
    assert_content 'メーター値: 256'
    assert_content 'テスター計測値: 512.0'
    assert_content '評価点: 128'
    assert_content '大きな問題なし'
    assert_content '点検実績記録者: 平良朱里'
    assert_content 'お客様署名(承認): 未(承認前)'

    # 最初に見つけた（メニューの ）点検依頼一覧リンクをクリックする
    click_link '点検作業対象一覧', {match: :first, exact: true}
    
    # 点検依頼一覧のみに遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '点検作業対象一覧'
    assert_content '作業確定日時'
    assert_content '型式'
    assert_content 'シリアルNo.'
    # テーブルの中の該当シリアルNoの行に承認(作業終了)リンクが存在することを確認
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '承認(作業終了)')    
 
  end
end