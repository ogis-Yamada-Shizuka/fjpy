# key in command below to run
# rake test TEST='test/integration/reply_candidate_dates_test.rb'
require "test_helper"
require "capybara/rails"

class ReplyCandidateDatesTest < Minitest::Capybara::Test
  def test_reply_candidate_dates
    # ---------------------------------------------------
    # サービス会社ユーザーが直近の点検依頼に対して候補日を回答(登録)する。
    # ---------------------------------------------------
    # 
    # 2.a User06でログイン
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

    # 2.b 装置システム一覧に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）点検依頼一覧(直近のみ)リンクをクリックする
    click_link '点検依頼一覧(直近のみ)', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '名称'
    assert_content '型式'
    assert_content '設置場所'
  
    # 2.c
    # テーブルの中の名称「」の行の候補日時回答リンクをクリック
    find(:xpath, "//tr[td[contains(.,'NEW_EQP')]]/td/a", :text => '候補日時回答').click
      
    # 候補日回答画面に遷移したことを確認
    assert_content '候補日時回答'
 
    # 新しい装置システムを入力
    # 装置名、型式、担当サービス会社を指定、それ以外はデフォルト
    fill_in 'inspection_schedule_candidate_datetime1',     with: '2016-4-10'
    fill_in 'inspection_schedule_candidate_datetime1',     with: '2016-4-20'
    fill_in 'inspection_schedule_candidate_datetime1',     with: '2016-4-30'
    fill_in 'inspection_schedule_candidate_datetime_memo', with: 'メモ'
    
    # 登録ボタンをクリック
    click_button '更新する'

    # 確認画面で入力した候補日が正しく表示されることを確認する
    assert_content '点検予定の確認'
    assert_content '2016年04月10日'
    assert_content '2016年04月20日'
    assert_content '2016年04月30日'
    
    # ステータスが候補日回答済みになっていることを確認する
    assert_content '候補日回答済み'

    click_link 'Back'

    # 1.e 装置システム一覧
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '名称'
    assert_content '型式'
    assert_content '設置場所'

    # 一覧の中に、先ほど登録した装置システムが存在することを確認する
    assert_content 'NEW_EQP'

    # SYS01の年月が「2016年04月」の点検予定が作成されている
    # 現在はまだ一覧には表示されないので下記は失敗になる
    assert_content '2016年04月'

  end
end