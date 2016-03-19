# key in command below to run
# rake test TEST='test/integration/sign_inspection_result_test.rb'
require "test_helper"

class SignInspectionResultTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules, :inspection_results, :checks, :measurements, :notes

  def test_sign_inspection_result
    # ---------------------------------------------------
    # サービス会社ユーザーにより顧客から点検結果の確認（サイン）を得る。
    # ---------------------------------------------------

    # テスト対象シリアルNo.
    serial_no = "S010-050"
    
    # User06でログイン
    signin('User06')    
        
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
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '承認(作業終了)').click    

    # 候補日回答画面に遷移したことを確認
    assert_content '承認(作業終了)'
    
    # 本来なら、ここでサインをもらう
    
    # 更新ボタンをクリック
    click_button '承認(作業終了)'

    # 点検予定の確認　画面に繊維する
    assert_content '点検予定の確認'
    assert_content 'サイン済'
    
  end
end
