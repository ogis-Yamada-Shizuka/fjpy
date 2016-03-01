# key in command below to run
# rake test TEST='test/integration/new_equipment_test.rb'
require "test_helper"
require "capybara/rails"

class NewEquipmentTest < Minitest::Capybara::Test
  def test_new_equipment
    # ---------------------------------------------------
    # YES拠点ユーザーが自拠点で管轄する装置を新規登録する。
    # ---------------------------------------------------
    # 
    # 1.a User03でログイン
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
    # 装置名、型式、担当サービス会社を指定、それ以外はデフォルト
    fill_in 'equipment_serial_number', with: 'NEW_EQP'
    select  '通常用(隔月点検)', from: 'equipment_system_model_id'
    select  'なにわサービス',   from: 'equipment_service_id'
    
    # 登録ボタンをクリック
    click_button '登録する'

    # 1.d 詳細画面
    # 装置システムのshow画面が表示されることを確認する
    assert_content '装置システムの確認'
    assert_content 'NEW_EQP'
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
    assert_content 'NEW_EQP'

    # SYS01の年月が「2016年04月」の点検予定が作成されている
    # 現在はまだ一覧には表示されないので下記は失敗になる
    # assert_content '2016年05月'

  end
end