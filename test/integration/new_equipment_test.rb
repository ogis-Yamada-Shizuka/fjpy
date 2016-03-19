# key in command below to run
# rake test TEST='test/integration/new_equipment_test.rb'
require "test_helper"

class NewEquipmentTest < AcstIntegrationTest
  def test_new_equipment_with_contract
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を新規登録する。
    # 　　保守契約ありの場合（点検予定が作られる）
    # ---------------------------------------------------
    
    # テスト対象シリアルNo.
    serial_no = "S010-000"
        
    # User02でログイン
    signin('User02')    

    # メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）装置システム一覧リンクをクリックする
    click_link '装置システム一覧', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 新規登録リンクをクリック    
    click_link '新規登録'
    
    # 新規登録画面に遷移したことを検証する
    assert_content '装置システムの登録'
 
    # 新しい装置システムを入力
    select  '通常用(隔月点検)', from: 'equipment_system_model_id'
    fill_in 'シリアルNo.', with: serial_no
    # 契約ありを選択
    check   '点検契約'
    fill_in '点検周期', with: 2
    select  '2016', from: 'equipment_start_date_1i'
    select  '3月',  from: 'equipment_start_date_2i'
    select  '10',   from: 'equipment_start_date_3i'
    select  'ゴム工業エイチ関西株式会社', from: 'equipment_place_id'
    assert_content '大阪第１'
    select  'なにわサービス',   from: 'equipment_service_id'
   
    # 登録ボタンをクリック
    click_button '登録する'

    # 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content 'Equipment was successfully created.'
    assert_content '装置システムの確認'
    assert_content serial_no
    assert_content '通常用(隔月点検)'
    assert_content 'なにわサービス'
    
    # 契約ありなので、点検予定が作られていることを確認する
    assert_link '直近の点検予定を確認する'

    click_link 'Back'

    # 装置システム一覧
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 一覧の中に、先ほど登録した装置システムが存在することを確認する
    assert_content serial_no
   
  end
  def test_new_equipment_without_contract
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を新規登録する。
    # 　　保守契約なしの場合（点検予定が作られない）
    # ---------------------------------------------------
    
    # テスト対象シリアルNo.
    serial_no = "S010-001"
        
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

    # 新規登録リンクをクリック    
    click_link '新規登録'
    
    # 新規登録画面に遷移したことを検証する
    assert_content '装置システムの登録'
 
    # 新しい装置システムを入力
    select  '通常用(隔月点検)', from: 'equipment_system_model_id'
    fill_in 'シリアルNo.', with: serial_no
    # 契約無しを選択
    uncheck '点検契約'
    fill_in '点検周期', with: 2
    select  '2016', from: 'equipment_start_date_1i'
    select  '3月',  from: 'equipment_start_date_2i'
    select  '10',   from: 'equipment_start_date_3i'
    select  'ゴム工業エイチ関西株式会社', from: 'equipment_place_id'
    assert_content '大阪第１'
    select  'なにわサービス',   from: 'equipment_service_id'
   
    # 登録ボタンをクリック
    click_button '登録する'

    # 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content 'Equipment was successfully created.'
    assert_content '装置システムの確認'
    assert_content serial_no
    assert_content '通常用(隔月点検)'
    assert_content 'なにわサービス'
    
    # 契約なしなので、点検予定が作られていないことを確認する
    assert_no_link '直近の点検予定を確認する'

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
