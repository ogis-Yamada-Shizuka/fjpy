# key in command below to run
# rake test TEST='test/integration/edit_equipment_test.rb'
require "test_helper"
require "integration_test_helper"
require "capybara/rails"

class EditEquipmentTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules

  def test_edit_equipment_turn_on_contract
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を変更登録する。
    # 　　保守契約なしからありに変更（新たに点検予定が作られる）
    # ---------------------------------------------------
    
    # テスト対象シリアルNo.
    serial_no = "S010-002"
        
    # User02でログイン
    visit '/'
 
    # ログイン画面が表示されたことを確認
    assert_content 'ログイン'
    
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

    # メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）装置システム一覧リンクをクリックする
    click_link '装置システム一覧', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # テーブルの中の該当シリアルNoの行の編集リンクをクリック
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '更新').click    
    
    # 編集登録画面に遷移したことを検証する
    assert_content '装置システムの更新'
 
    # 点検契約のみをＯＮにする
    # 契約ありを選択
    check '点検契約'
   
    # 登録ボタンをクリック
    click_button '更新する'

    # 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content 'Equipment was successfully updated.'
    assert_content '装置システムの確認'
    assert_content serial_no
    assert_content '通常用(隔月点検)'
    assert_content 'なにわサービス'
    
    # 契約ありになったので、点検予定が作られていないことを確認する
    assert_link '直近の点検予定を確認する'

    click_link 'Back'

    # 装置システム一覧
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 一覧の中に、先ほど変更した装置システムが存在することを確認する
    assert_content serial_no
   
  end
  def test_edit_equipment_turn_off_contract
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を変更登録する。
    # 　　保守契約なしからありに変更（新たに点検予定が作られる）
    # ---------------------------------------------------
    
    # テスト対象シリアルNo.
    serial_no = "S010-003"
        
    # User02でログイン
    visit '/'
 
    # ログイン画面が表示されたことを確認
    assert_content 'ログイン'
    
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

    # メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）装置システム一覧リンクをクリックする
    click_link '装置システム一覧', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # テーブルの中の該当シリアルNoの行の編集リンクをクリック
    find(:xpath, "//tr[td[contains(.,'" + serial_no + "')]]/td/a", :text => '更新').click    
    
    # 編集登録画面に遷移したことを検証する
    assert_content '装置システムの更新'
 
    # 点検契約のみをＯＮにする
    # 契約ありを選択
    check '点検契約'
   
    # 登録ボタンをクリック
    click_button '更新する'

    # 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content 'Equipment was successfully updated.'
    assert_content '装置システムの確認'
    assert_content serial_no
    assert_content '通常用(隔月点検)'
    assert_content 'なにわサービス'
    
    # 契約なしなので、点検予定が作られていないことを確認する
    assert_link    '直近の点検予定を確認する'

    click_link 'Back'

    # 装置システム一覧
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 一覧の中に、先ほど登録した装置システムが存在することを確認する
    assert_content serial_no
   
  end
end