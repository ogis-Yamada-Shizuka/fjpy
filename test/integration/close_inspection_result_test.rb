# key in command below to run
# rake test TEST='test/integration/close_inspection_result_test.rb'
require "test_helper"

class CloseInspectionResultTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules, :inspection_results, :checks, :measurements, :notes

  def test_close_inspection_result
    # ---------------------------------------------------
    # 拠点ユーザーが点検結果を承認し、点検を完了させる。
    # ---------------------------------------------------

    # テスト対象シリアルNo.
    serial_no = "S010-060"
    
    # User02でログイン
    signin('User02')
    
    # メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの ）点検依頼一覧リンクをクリックする
    click_link '点検作業完了一覧', {match: :first, exact: true}
    
    # 点検依頼一覧のみに遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '点検作業完了一覧'
    assert_content '作業確定日時'
    assert_content '型式'
    assert_content 'シリアルNo.'
    assert_content '設置場所'
  
    # テーブルの中の該当シリアルNoの行の候補日時回答リンクをクリック
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '点検の完了').click    

    # 候補日回答画面に遷移したことを確認
    assert_content '点検の完了'
    
    # 更新ボタンをクリック
    select  '2016', from: 'when_year'
    select  '5月', from: 'when_month'

    # 点検の完了ボタンをクリック
    click_button '点検の完了'

    # 「点検予定の確認」画面に遷移する
    assert_content '点検予定の確認'
    # ステータスが完了になっていることを確認する
    assert_content '完了'
         
  end
end
