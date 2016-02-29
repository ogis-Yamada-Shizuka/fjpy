# key in command below to run
# rake test TEST='test/features/sprint2_test.rb'

require "test_helper"

feature "sprint2" do
  scenario "1.装置システムを新規登録" do
    
    # User03でログイン
    visit root_path
    page.must_have_content "ログイン"
 
    # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User02'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'
    # ログインに成功したことを検証する
    page.must_have_content 'ログインしました'
    page.must_have_content 'メニュー'
    page.must_have_content '村山音々'
    page.must_have_content '大阪第１'
        
    visit root_path
    page.must_have_content 'メニュー'
    
    # 最初に見つけた（メニューの）装置システム一覧リンクをクリックする
    click_link '装置システム一覧', match: :first
    # 装置システム一覧に遷移したことを検証する（タイトルだとわからないので複数の列ヘッダで検証）
    page.must_have_content '名称'
    page.must_have_content '型式'
    page.must_have_content '設置場所'
  
    # 新規登録リンクをクリック    
    click_link '新規登録'
    
    # 新規登録画面に遷移したことを検証する
    page.must_have_content '装置システムの登録'
 
    # 新しい装置システムを入力
    # 装置名、型式、担当サービス会社を指定、それ以外はデフォルト
    fill_in 'equipment_name', with: 'SYS01'
    select "通常用(隔月点検)",  from: "equipment_system_model_id"
    select "なにわサービス",    from: "equipment_service_id"
    
    # 登録ボタンをクリック
    click_button '登録する'

    # 装置システムのshow画面が表示されることを確認する
    page.must_have_content '装置システムの確認'
    page.must_have_content 'SYS01'
    page.must_have_content '通常用(隔月点検)'
    page.must_have_content 'なにわサービス'
    page.must_have_content '直近の点検予定を確認する(2016年04月)'
    # puts page.body

    # トップ画面に戻る
    visit root_path
    page.must_have_content 'メニュー'
    
    # 点検依頼一覧を表示
    click_link '点検依頼一覧(直近のみ)', match: :first
    
    # 新規登録した装置システムが一覧に表示されていることを確認
    page.must_have_content '2016年04月'
    page.must_have_content 'SYS01'
    
    # User02をログアウトする
    click_link 'ログアウト'
    
    # ログイン画面に戻ったことを確認する
    page.must_have_content "ログイン"
    
  # end

  # scenario "2.サービス会社が候補日を入力する" do
    
    # User06でログイン
    visit root_path
    page.must_have_content "ログイン"
 
    # ユーザＩＤとパスワードを入力
    fill_in 'user_userid',   with: 'User06'
    fill_in 'user_password', with: 'password'

    # ログインボタンをクリックする
    click_on 'Log in'
    # ログインに成功したことを検証する
    page.must_have_content 'ログインしました'
    page.must_have_content 'メニュー'
    page.must_have_content '平良朱里'
    page.must_have_content 'なにわサービス'
    
    # メニュー画面に遷移する
    visit root_path
    page.must_have_content 'メニュー'
    
    # 点検依頼一覧を表示
    click_link '点検依頼一覧(直近のみ)', match: :first
    
    # User03が登録した装置に対する点検依頼が一覧に表示されていることを確認
    page.must_have_content '2016年04月'
    page.must_have_content 'SYS01'
    page.must_have_content '候補日時回答'
    
    # その行の候補日時回答をクリック（1行目に出ているはずなので、最初の要素をクリック）
    click_link '候補日時回答', match: :first
    
    # 候補日回答画面に遷移したことを確認
    page.must_have_content '候補日時回答'
    
  end

end
