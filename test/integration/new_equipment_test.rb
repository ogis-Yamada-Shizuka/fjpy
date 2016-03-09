# key in command below to run
# rake test TEST='test/integration/new_equipment_test.rb'
require "test_helper"
require "integration_test_helper"
require "capybara/rails"

class NewEquipmentTest < AcstIntegrationTest
  def test_new_equipment
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を新規登録する。
    # ---------------------------------------------------
    # 
    # 1.a User02でログイン
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

    # 1.b メニュー画面に遷移
    visit '/'

    # 最初に見つけた（メニューの  ）装置システム一覧リンクをクリックする
    click_link '装置システム一覧', match: :first

    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 新規登録リンクをクリック    
    click_link '新規登録'
    
    # 1.c 新規登録画面
    # 新規登録画面に遷移したことを検証する
    assert_content '装置システムの登録'
 
    # 新しい装置システムを入力
    select  '通常用(隔月点検)', from: 'equipment_system_model_id'
    fill_in 'シリアルNo.', with: 'S010-000'
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

    # 1.d 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content 'Equipment was successfully created.'
    assert_content '装置システムの確認'
    assert_content 'S010-000'
    assert_content '通常用(隔月点検)'
    assert_content 'なにわサービス'
    assert_content '直近の点検予定を確認する(2016年05月)'

    click_link 'Back'

    # 1.e 装置システム一覧
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    assert_content 'シリアルNo.'
    assert_content '型式'
    assert_content '設置場所'

    # 一覧の中に、先ほど登録した装置システムが存在することを確認する
    assert_content 'S010-000'

    puts Equipment.find(101).to_s
    
  end
end