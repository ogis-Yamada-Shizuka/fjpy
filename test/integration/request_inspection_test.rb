# key in command below to run
# rake test TEST='test/integration/request_inspection_test.rb'
require "test_helper"

class RequestInspectionTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules

  def test_request_inspection
    # ---------------------------------------------------
    # 拠点ユーザーがサービス会社に対して点検依頼を行う。
    # ---------------------------------------------------

    # テスト対象シリアルNo.
    serial_no = "S010-010"
     
    # User02でログイン
    signin('User02')    
    
    # メニューに遷移
    visit '/'

    # 最初に見つけた（メニューの  ）要点検依頼一覧リンクをクリックする
    click_link '要点検依頼一覧(直近２ヶ月のみ)', match: :first

    # 要点検依頼一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content '年月'
    assert_content 'シリアルNo.'
    assert_content '設置場所'
    assert_content '担当サービス会社'
  
    # テーブルの中の該当シリアルNoの行の点検依頼リンクをクリック
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '点検依頼').click    
    
    # 点検依頼画面に遷移したことを確認
    assert_content '点検依頼'
    assert_content '担当サービス会社'
    
    # 担当サービス会社になにわサービスを選択して、登録ボタンをクリック
    select 'なにわサービス', from: '担当サービス会社'
    click_button '更新する'

    # 「点検予定の確認」画面に遷移したこと、点検依頼済みになっていることを確認
    assert_content '点検予定の確認'
    assert_content serial_no
    assert_content '点検依頼済'
    assert_content '点検依頼者: 村山音々'
    
  end
end
