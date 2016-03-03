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

    # 点検依頼一覧(直近のみに遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '年月'
    assert_content '対象装置システム'
    assert_content '設置場所'
  
    # 2.c
    # テーブルの中の名称「」の行の候補日時回答リンクをクリック
    find(:xpath, "//tr[td[contains(.,'NEW_EQP')]]/td/a", :text => '候補日時回答').click
      
    # 候補日回答画面に遷移したことを確認
    assert_content '候補日時回答'
 
    # datepickerによる日付のセットがうまく行かないので、テスト範囲から除外
    # Capybara.javascript_driver = :webkit
    
    # 候補日1-3を入力
    # fill_in 'inspection_schedule_candidate_datetime1',     with: '2016/04/10'
    # fill_in 'inspection_schedule_candidate_datetime2',     with: '2016/04/20'
    # fill_in 'inspection_schedule_candidate_datetime3',     with: '2016/04/30'
    # page.execute_script("$('#inspection_schedule_candidate_datetime1').val('10/04/2016')")
    # page.execute_script("$('#inspection_schedule_candidate_datetime2').val('10/04/2016')")
    # page.execute_script("$('#inspection_schedule_candidate_datetime3').val('10/04/2016')")
    # page.execute_script("$('inspection_schedule_candidate_datetime1').datepicker('setDate', '10/04/2016')")
    # page.execute_script("$('inspection_schedule_candidate_datetime2').datepicker('setDate', '20/04/2016')")
    # page.execute_script("$('inspection_schedule_candidate_datetime3').datepicker('setDate', '30/04/2016')")

    fill_in 'inspection_schedule_candidate_datetime_memo', with: 'メモです'
    
    # 登録ボタンをクリック
    click_button '更新する'

    # 確認画面で入力した候補日が正しく表示されることを確認する
    assert_content '点検予定の確認'

    # datepickerによる日付のセットがうまく行かないので、テスト範囲から除外
    #assert_content '2016年04月10日'　datepickerでの入力のため、うまく値がセットできていない。
    #assert_content '2016年04月20日'　datepickerでの入力のため、うまく値がセットできていない。
    #assert_content '2016年04月30日'　datepickerでの入力のため、うまく値がセットできていない。

    assert_content 'メモです'
    
    # ステータスが候補日回答済みになっていることを確認する
    assert_content '候補日回答済'

    click_link 'Back'

  end
end