# key in command below to run
# rake test TEST='test/integration/signin_test.rb'
require "test_helper"

class SigninTest < AcstIntegrationTest

  fixtures :equipment, :inspection_schedules
  
  def test_signin
    # 
    # サインインのみのテスト（User03でログイン）
    # 
    signin('User02')

    # ログインに成功したことを検証する
    assert_content 'ログインしました'
    assert_content 'メニュー'
    assert_content '大阪第１'
    assert_content '村山音々'

  end
end
