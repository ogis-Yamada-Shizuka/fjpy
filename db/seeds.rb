# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# ScheduleStatus(進捗状況)テーブルに初期値を投入(全件削除して再投入)
ScheduleStatus.delete_all
['要点検依頼', '点検依頼済', '候補日回答済', '出張依頼済', '点検報告作成済', 'サイン済', '承認済', 'NG'].each.with_index(1) do |name, id|
  ScheduleStatus.create(id: id, name: name)
end
if Rails.env.development?
  ScheduleStatus.connection.execute("update sqlite_sequence set seq=7 where name='schedule_statuses'")
else
  ScheduleStatus.connection.execute("SELECT SETVAL('schedule_statuses_id_seq', 7, TRUE)")
end

# Weather(天気)テーブルに初期値を投入(全件削除して再投入)
Weather.delete_all
Weather.create(id: 1, name: '晴')
Weather.create(id: 2, name: '曇')
Weather.create(id: 3, name: '雨')
Weather.create(id: 4, name: '雪')
if Rails.env.development?
  Weather.connection.execute("update sqlite_sequence set seq=4 where name='weathers'")
else
  Weather.connection.execute("SELECT SETVAL('weathers_id_seq', 4, TRUE)")
end

# Checkresult(チェック結果)テーブルに初期値を投入(全件削除して再投入)
Checkresult.delete_all
Checkresult.create(id: 1, name: '優')
Checkresult.create(id: 2, name: '良')
Checkresult.create(id: 3, name: '可')
Checkresult.create(id: 4, name: '不可')
if Rails.env.development?
  Checkresult.connection.execute("update sqlite_sequence set seq=4 where name='checkresults'")
else
  Checkresult.connection.execute("SELECT SETVAL('checkresults_id_seq', 4, TRUE)")
end

# Flag(フラグ)テーブルに初期値を投入(全件削除して再投入)
Flag.delete_all
Flag.create(id: 1, name: 'Open')
Flag.create(id: 2, name: 'Close')
if Rails.env.development?
  Weather.connection.execute("update sqlite_sequence set seq=2 where name='flasg'")
else
  Weather.connection.execute("SELECT SETVAL('flags_id_seq', 2, TRUE)")
end

############################################################################
### ここから先はデモ用サンプルデータの投入 ※いずれ別ファイルに切り出したい
############################################################################

##########################
### テスト用にデータを入れる（超暫定)
##########################

# Company(会社)テーブルに初期値を投入(全件削除して再投入)
Company.delete_all
Head.create(id: 1, code: 'HdO-01', name: '本社')
Branch.create(id: 2, code: 'OSK-01', name: '大阪第１')
Branch.create(id: 3, code: 'OSK-02', name: '大阪第２')
Branch.create(id: 4, code: 'NGY-01', name: '名古屋営業所')
Branch.create(id: 5, code: 'TKY-01', name: '東京支社')
Service.create(id: 6, code: 'SER-01', name: 'なにわサービス', branch_id: 2)
Service.create(id: 7, code: 'SER-02', name: '大阪点検サポート', branch_id: 2)
Service.create(id: 8, code: 'SER-03', name: '(有)難波設備', branch_id: 3)
Service.create(id: 9, code: 'SER-04', name: '阪神施設管理(株)', branch_id: 3)
Service.create(id: 10, code: 'SER-05', name: '(株)名古屋設備点検', branch_id: 4)
Service.create(id: 11, code: 'SER-06', name: '中京サービス', branch_id: 4)
Service.create(id: 12, code: 'SER-07', name: 'むさしサポート(株)', branch_id: 5)
if Rails.env.development?
  Company.connection.execute("update sqlite_sequence set seq=12 where name='companies'")
else
  Company.connection.execute("SELECT SETVAL('companies_id_seq', 12, TRUE)")
end

# SystemModel(型式)テーブルに初期値を投入(全件削除して再投入)
SystemModel.delete_all
SystemModel.create(id: 1, name: '通常用(毎月点検)', inspection_cycle_month: 1)
SystemModel.create(id: 2, name: '通常用(隔月点検)', inspection_cycle_month: 2)
SystemModel.create(id: 3, name: '通常用(半年毎点検)', inspection_cycle_month: 6)
SystemModel.create(id: 4, name: '非常用(１年毎点検)', inspection_cycle_month: 12)
SystemModel.create(id: 5, name: '携帯用(３年毎点検)', inspection_cycle_month: 36)
if Rails.env.development?
  SystemModel.connection.execute("update sqlite_sequence set seq=5 where name='system_models'")
else
  SystemModel.connection.execute("SELECT SETVAL('system_models_id_seq', 5, TRUE)")
end

# Place(場所)テーブルに初期値を投入(全件削除して再投入)
Place.delete_all

# TODO: branch_id は実際のものでなく仮で実装している
Place.create(id: 1, name: 'ゴム工業エイチ関西株式会社', address: '七尾市中島町大平91丁目523-4580', branch_id: 2)
Place.create(id: 2, name: '株式会社インキ丸紅マキタ', address: '鳥取市気高町下坂本70丁目2807-8603', branch_id: 2)
Place.create(id: 3, name: '高崎健康福祉大学', address: '大阪府堺市南区新檜尾台', branch_id: 2)
Place.create(id: 4, name: '大機グループヤマト有限会社', address: '登米市米山町西野58丁目5638-7130', branch_id: 2)
Place.create(id: 5, name: '大丸システムズ内外株式会社', address: '本巣市木知原99丁目8635-2984', branch_id: 2)
Place.create(id: 6, name: '北九州大学', address: '徳島県徳島市国府町東黒田', branch_id: 2)
Place.create(id: 7, name: '大機テトラエー株式会社', address: '小豆郡小豆島町田浦81丁目1076-193', branch_id: 3)
Place.create(id: 8, name: 'セブンティサン有限会社', address: '北設楽郡設楽町三都橋60丁目3206-7865', branch_id: 3)
Place.create(id: 9, name: '株式会社協和高島宇部', address: '中頭郡北中城村大城57丁目7067-9176', branch_id: 3)
Place.create(id: 10, name: '株式会社ハルテックバルブホームズ', address: '西尾市吉良町大島92丁目3396-1213', branch_id: 3)
Place.create(id: 11, name: 'ユアサ九州グループ組合', address: '富山市下栗山73丁目9833-6589', branch_id: 3)
Place.create(id: 12, name: '金沢大学', address: '京都府京都市山科区西野小柳町', branch_id: 3)
Place.create(id: 13, name: '山口福祉文化大学', address: '青森県三沢市三沢', branch_id: 3)
Place.create(id: 14, name: '株式会社マキタ京王両備', address: '大阪市此花区島屋54丁目7042-3946', branch_id: 4)
Place.create(id: 15, name: 'テクノロジー東和丸紅株式会社', address: '岡山市北区島田本町83丁目8506-5154', branch_id: 4)
Place.create(id: 16, name: '大阪国際大学', address: '愛知県稲沢市一色道上町', branch_id: 4)
Place.create(id: 17, name: '岐阜薬科大学', address: '愛知県豊川市御津町赤根松葉', branch_id: 4)
Place.create(id: 18, name: '日本歯科大学', address: '和歌山県西牟婁郡白浜町玉伝', branch_id: 4)
Place.create(id: 19, name: '島根県立大学', address: '長崎県佐世保市新港町', branch_id: 4)
Place.create(id: 20, name: '京王リース不二組合', address: '駿東郡小山町大胡田54丁目4644-5061', branch_id: 4)
Place.create(id: 21, name: 'テンプ高島東洋有限会社', address: '岩瀬郡天栄村飯豊60丁目5435-6963', branch_id: 4)
Place.create(id: 22, name: '有限会社ゴム工業グループピー', address: '芳賀郡芳賀町上延生48丁目6804-6555', branch_id: 4)
Place.create(id: 23, name: '千代田エム北海道株式会社', address: '岡山市東区金岡西町27丁目9792-4892', branch_id: 5)
Place.create(id: 24, name: '立命館アジア太平洋大学', address: '岩手県奥州市水沢区雀田', branch_id: 5)
Place.create(id: 25, name: '札幌市立大学', address: '山形県鶴岡市岡山', branch_id: 5)
Place.create(id: 26, name: 'ユアサエムアイカーボン合資会社', address: '高山市朝日町見座99丁目5331-2106', branch_id: 5)
Place.create(id: 27, name: '帝京平成大学', address: '京都府舞鶴市吉田', branch_id: 5)
Place.create(id: 28, name: '株式会社ストアバイエルクリエイト', address: '名古屋市中村区沖田町78丁目4478-8200', branch_id: 5)
Place.create(id: 29, name: '松本大学', address: '鳥取県倉吉市見日町', branch_id: 5)
Place.create(id: 30, name: 'フジゴルフプラス株式会社', address: '上北郡七戸町中村53丁目8378-2885', branch_id: 5)

if Rails.env.development?
  Place.connection.execute("update sqlite_sequence set seq=30 where name='places'")
else
  Place.connection.execute("SELECT SETVAL('places_id_seq', 30, TRUE)")
end

# User(作業者)テーブルにテスト用初期値を投入（全件削除して再投入）
User.delete_all
if Rails.env.development?
  User.connection.execute("delete from sqlite_sequence where name='users'")
else
  User.connection.execute("SELECT SETVAL('users_id_seq',1,FALSE)")
end
User.create( userid: 'User01', name: '谷川光正', company_id: 1, email: 'user01@fujipy.com', password: 'password' )
User.create( userid: 'User02', name: '村山音々', company_id: 2, email: 'user02@fujipy.com', password: 'password' )
User.create( userid: 'User03', name: '村山野乃', company_id: 3, email: 'user03@fujipy.com', password: 'password' )
User.create( userid: 'User04', name: '佐伯林檎', company_id: 4, email: 'user04@fujipy.com', password: 'password' )
User.create( userid: 'User05', name: '大竹美貴', company_id: 5, email: 'user05@fujipy.com', password: 'password'  )
User.create( userid: 'User06', name: '平良朱里', company_id: 6, email: 'user06@fujipy.com', password: 'password'  )
User.create( userid: 'User07', name: '渥美健吉', company_id: 7, email: 'user07@fujipy.com', password: 'password'  )
User.create( userid: 'User08', name: '新倉満',   company_id: 8, email: 'user08@fujipy.com', password: 'password'  )
User.create( userid: 'User09', name: '松本真理子', company_id: 9, email: 'user91@fujipy.com', password: 'password'  )
User.create( userid: 'User10', name: '湯川恒敏', company_id: 10, email: 'user10@fujipy.com', password: 'password'  )
User.create( userid: 'User11', name: '田辺澄子', company_id: 11, email: 'user11@fujipy.com', password: 'password'  )
User.create( userid: 'User12', name: '新垣香里', company_id: 12, email: 'user12@fujipy.com', password: 'password'  )
User.create( userid: 'User13', name: '辻本恵美', company_id: 1, email: 'user13@fujipy.com', password: 'password'  )
User.create( userid: 'User14', name: '高津一花', company_id: 2, email: 'user14@fujipy.com', password: 'password'  )
User.create( userid: 'User15', name: '名取和弥', company_id: 3, email: 'user15@fujipy.com', password: 'password'  )
User.create( userid: 'User16', name: '毛利豊子', company_id: 4, email: 'user16@fujipy.com', password: 'password'  )
User.create( userid: 'User17', name: '矢野茉奈', company_id: 5, email: 'user17@fujipy.com', password: 'password'  )
User.create( userid: 'User18', name: '高村一葉', company_id: 6, email: 'user18@fujipy.com', password: 'password'  )
User.create( userid: 'User19', name: '角千代乃', company_id: 7, email: 'user19@fujipy.com', password: 'password' )
User.create( userid: 'User20', name: '滋賀浩二', company_id: 8, email: 'user20@fujipy.com', password: 'password'  )
User.create( userid: 'User21', name: '三原清一郎', company_id: 9, email: 'user21@fujipy.com', password: 'password'  )
User.create( userid: 'User22', name: '手島与三郎', company_id: 10, email: 'user22@fujipy.com', password: 'password'  )
User.create( userid: 'User23', name: '小山柚衣', company_id: 11, email: 'user23@fujipy.com', password: 'password'  )
User.create( userid: 'User24', name: '井田華蓮', company_id: 12, email: 'user24@fujipy.com', password: 'password'  )
User.create( userid: 'User25', name: '飛田繁雄', company_id: 1, email: 'user25@fujipy.com', password: 'password'  )
User.create( userid: 'User26', name: '三井幸太郎', company_id: 2, email: 'user26@fujipy.com', password: 'password'  )
User.create( userid: 'User27', name: '坂上宗雄', company_id: 3, email: 'user27@fujipy.com', password: 'password'  )
User.create( userid: 'User28', name: '佐竹良雄', company_id: 4, email: 'user28@fujipy.com', password: 'password'  )
User.create( userid: 'User29', name: '越智沙彩', company_id: 5, email: 'user29@fujipy.com', password: 'password'  )
User.create( userid: 'User30', name: '佐竹恵利', company_id: 1, email: 'user30@fujipy.com', password: 'password'  )
User.create( userid: 'User31', name: '宮下和之', company_id: 2, email: 'user31@fujipy.com', password: 'password'  )
User.create( userid: 'User32', name: '長友碧依', company_id: 3, email: 'user32@fujipy.com', password: 'password'  )
User.create( userid: 'User33', name: '藤村英俊', company_id: 4, email: 'user33@fujipy.com', password: 'password'  )
User.create( userid: 'User34', name: '坪井晴雄', company_id: 5, email: 'user34@ujipy.com', password: 'password'  )
User.create( userid: 'User35', name: '藤木咲子', company_id: 1, email: 'user35@fujipy.com', password: 'password'  )
User.create( userid: 'User36', name: '米倉武男', company_id: 2, email: 'user36@fujipy.com', password: 'password'  )
User.create( userid: 'User37', name: '柴田亜由美', company_id: 3, email: 'user37@fujipy.com', password: 'password'  )
User.create( userid: 'User38', name: '坂野邦夫', company_id: 4, email: 'user38@fujipy.com', password: 'password'  )
User.create( userid: 'User39', name: '仲村留吉', company_id: 5, email: 'user39@fujipy.com', password: 'password'  )
User.create( userid: 'User40', name: '森田理', company_id: 1, email: 'user40@fujipy.com', password: 'password'  )
User.create( userid: 'User41', name: '児玉莉子', company_id: 2, email: 'user41@fujipy.com', password: 'password'  )
User.create( userid: 'User42', name: '関本花帆', company_id: 3, email: 'user42@fujipy.com', password: 'password'  )
User.create( userid: 'User43', name: '岩永良子', company_id: 4, email: 'user43@fujipy.com', password: 'password'  )
User.create( userid: 'User44', name: '高坂真理子', company_id: 5, email: 'user44@fujipy.com', password: 'password'  )
User.create( userid: 'User45', name: '野村啓二', company_id: 1, email: 'user45@fujipy.com', password: 'password'  )
User.create( userid: 'User46', name: '平松幸治', company_id: 2, email: 'user46@fujipy.com', password: 'password'  )
User.create( userid: 'User47', name: '北田敏幸', company_id: 3, email: 'user47@fujipy.com', password: 'password'  )
User.create( userid: 'User48', name: '山岸義美', company_id: 4, email: 'user48@fujipy.com', password: 'password'  )
User.create( userid: 'User49', name: '坂上治', company_id: 5, email: 'user49@fujipy.com', password: 'password'  )
User.create( userid: 'User50', name: '志賀棟上', company_id: 1, email: 'user50@fujipy.com', password: 'password'  )
User.create( userid: 'User51', name: '塩谷信行', company_id: 2, email: 'user51@fujipy.com', password: 'password'  )
User.create( userid: 'User52', name: '松沢信長', company_id: 3, email: 'user52@fujipy.com', password: 'password'  )
User.create( userid: 'User53', name: '五味真樹', company_id: 4, email: 'user53@fujipy.com', password: 'password'  )
User.create( userid: 'User54', name: '山岸良彦', company_id: 5, email: 'user54@fujipy.com', password: 'password'  )
User.create( userid: 'User55', name: '荒井柚衣', company_id: 1, email: 'user55@fujipy.com', password: 'password'  )
User.create( userid: 'User56', name: '中尾理子', company_id: 2, email: 'user56@fujipy.com', password: 'password'  )
User.create( userid: 'User57', name: '森井双葉', company_id: 3, email: 'user57@fujipy.com', password: 'password'  )
User.create( userid: 'User58', name: '清野久子', company_id: 4, email: 'user58@fujipy.com', password: 'password'  )
User.create( userid: 'User59', name: '岩永翔子', company_id: 5, email: 'user59@fujipy.com', password: 'password'  )
User.create( userid: 'User60', name: '田口昌己', company_id: 1, email: 'user60@fujipy.com', password: 'password'  )
User.create( userid: 'User61', name: '戸田優奈', company_id: 2, email: 'user61@fujipy.com', password: 'password'  )
User.create( userid: 'User62', name: '首藤瑞穂', company_id: 3, email: 'user62@fujipy.com', password: 'password'  )
User.create( userid: 'User63', name: '富田隆吾', company_id: 4, email: 'user63@fujipy.com', password: 'password'  )
User.create( userid: 'User64', name: '川嶋悠', company_id: 5, email: 'user64@fujipy.com', password: 'password'  )
User.create( userid: 'User65', name: '金谷亮太', company_id: 1, email: 'user65@fujipy.com', password: 'password'  )
User.create( userid: 'User66', name: '藤崎文音', company_id: 2, email: 'user66@fujipy.com', password: 'password'  )
User.create( userid: 'User67', name: '浜野幸二', company_id: 3, email: 'user67@fujipy.com', password: 'password'  )
User.create( userid: 'User68', name: '中島政次', company_id: 4, email: 'user68@fujipy.com', password: 'password'  )
User.create( userid: 'User69', name: '渋谷洋二', company_id: 5, email: 'user69@fujipy.com', password: 'password'  )
User.create( userid: 'User70', name: '増田綾花', company_id: 1, email: 'user70@fujipy.com', password: 'password'  )
User.create( userid: 'User71', name: '安部和雄', company_id: 2, email: 'user71@fujipy.com', password: 'password'  )
User.create( userid: 'User72', name: '武田利雄', company_id: 3, email: 'user72@fujipy.com', password: 'password'  )
User.create( userid: 'User73', name: '花岡淑子', company_id: 4, email: 'user73@fujipy.com', password: 'password'  )
User.create( userid: 'User74', name: '吉沢秀吉', company_id: 5, email: 'user74@fujipy.com', password: 'password'  )
User.create( userid: 'User75', name: '足立五月', company_id: 1, email: 'user75@fujipy.com', password: 'password'  )
User.create( userid: 'User76', name: '我妻忠男', company_id: 2, email: 'user76@fujipy.com', password: 'password'  )
User.create( userid: 'User77', name: '安斎優華', company_id: 2, email: 'user77@fujipy.com', password: 'password'  )
User.create( userid: 'User78', name: '鳥居顕子', company_id: 3, email: 'user78@fujipy.com', password: 'password'  )
User.create( userid: 'User79', name: '高柳健吉', company_id: 4, email: 'user79@fujipy.com', password: 'password'  )
User.create( userid: 'User80', name: '矢口孝宏', company_id: 5, email: 'user80@fujipy.com', password: 'password'  )
User.create( userid: 'User81', name: '手島弘', company_id: 1, email: 'user81@fujipy.com', password: 'password'  )
User.create( userid: 'User82', name: '渋谷美名子', company_id: 2, email: 'user82@fujipy.com', password: 'password'  )
User.create( userid: 'User83', name: '日下部雅博', company_id: 3, email: 'user83@fujipy.com', password: 'password'  )
User.create( userid: 'User84', name: '大山清次', company_id: 4, email: 'user84@fujipy.com', password: 'password'  )
User.create( userid: 'User85', name: '宮島久男', company_id: 5, email: 'user85@fujipy.com', password: 'password'  )
User.create( userid: 'User86', name: '田代紀子', company_id: 1, email: 'user86@fujipy.com', password: 'password'  )
User.create( userid: 'User87', name: '中嶋優子', company_id: 2, email: 'user87@fujipy.com', password: 'password'  )
User.create( userid: 'User88', name: '寺尾正敏', company_id: 3, email: 'user88@fujipy.com', password: 'password'  )
User.create( userid: 'User90', name: '本橋紀之', company_id: 4, email: 'user90@fujipy.com', password: 'password'  )
User.create( userid: 'User91', name: '長井利治', company_id: 5, email: 'user91@fujipy.com', password: 'password'  )
User.create( userid: 'User92', name: '菅沼陽華', company_id: 1, email: 'user92@fujipy.com', password: 'password'  )
User.create( userid: 'User93', name: '小山田聡子', company_id: 2, email: 'user93@fujipy.com', password: 'password'  )
User.create( userid: 'User94', name: '長嶋歩', company_id: 3, email: 'user94@fujipy.com', password: 'password'  )
User.create( userid: 'User95', name: '川口勇', company_id: 4, email: 'user95@fujipy.com', password: 'password'  )
User.create( userid: 'User96',name: '菅野沙也佳', company_id: 5, email: 'user96@fujipy.com', password: 'password'  )
User.create( userid: 'User97', name: '富山英世', company_id: 1, email: 'user97@fujipy.com', password: 'password'  )
User.create( userid: 'User98', name: '広田浩司', company_id: 2, email: 'user98@fujipy.com', password: 'password'  )
User.create( userid: 'User99', name: '安井敦', company_id: 3, email: 'user99@fujipy.com', password: 'password'  )
User.create( userid: 'User99', name: '安部利恵', company_id: 4, email: 'user01@fujipy.com', password: 'password'  )
User.create( userid: 'User00', name: '本村結芽', company_id: 5, email: 'useraa@fujipy.com', password: 'password'  )

# Equipment(装置システム)テーブルにテスト用初期値を投入（全件削除して再投入）
Equipment.delete_all
if Rails.env.development?
  Equipment.connection.execute("delete from sqlite_sequence where name='equipment'")
else
  Equipment.connection.execute("SELECT SETVAL('equipment_id_seq',1,FALSE)")
end

# 装置システムの登録前に点検予定を全件削除　※装置し捨て鵜登録時に点検予定を自動生成するため
InspectionSchedule.delete_all
if Rails.env.development?
  InspectionSchedule.connection.execute("delete from sqlite_sequence where name='inspection_schedules'")
else
  InspectionSchedule.connection.execute("SELECT SETVAL('inspection_schedules_id_seq',1,FALSE)")
end

start_date_today = Time.zone.today.in_time_zone
Equipment.create( serial_number: 'SYS-001', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 1, branch_id: 2, service_id: 6 )
Equipment.create( serial_number: 'SYS-002', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 1, branch_id: 2, service_id: 6 )
Equipment.create( serial_number: 'SYS-003', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 2, branch_id: 2, service_id: 6 )
Equipment.create( serial_number: 'SYS-004', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 3, branch_id: 2, service_id: 6 )
Equipment.create( serial_number: 'SYS-005', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 1, branch_id: 2, service_id: 7 )
Equipment.create( serial_number: 'SYS-005', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 1, branch_id: 2, service_id: 7 )
Equipment.create( serial_number: 'SYS-007', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 4, branch_id: 2, service_id: 7 )
Equipment.create( serial_number: 'SYS-008', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 5, branch_id: 2, service_id: 7 )
Equipment.create( serial_number: 'SYS-009', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 6, branch_id: 3, service_id: 8 )
Equipment.create( serial_number: 'SYS-010', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 6, branch_id: 3, service_id: 8 )
Equipment.create( serial_number: 'SYS-011', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 7, branch_id: 3, service_id: 8 )
Equipment.create( serial_number: 'SYS-012', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 8, branch_id: 3, service_id: 8 )
Equipment.create( serial_number: 'SYS-013', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 6, branch_id: 3, service_id: 9 )
Equipment.create( serial_number: 'SYS-014', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 6, branch_id: 3, service_id: 9 )
Equipment.create( serial_number: 'SYS-015', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 9, branch_id: 3, service_id: 9 )
Equipment.create( serial_number: 'SYS-016', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 10, branch_id: 3, service_id: 9 )
Equipment.create( serial_number: 'SYS-017', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 11, branch_id: 4, service_id: 10 )
Equipment.create( serial_number: 'SYS-018', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 12, branch_id: 4, service_id: 10 )
Equipment.create( serial_number: 'SYS-019', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 13, branch_id: 4, service_id: 10 )
Equipment.create( serial_number: 'SYS-020', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 14, branch_id: 4, service_id: 10 )
Equipment.create( serial_number: 'SYS-021', inspection_cycle_month: 36, inspection_contract: true, start_date: start_date_today, system_model_id: 5, place_id: 15, branch_id: 4, service_id: 11 )
Equipment.create( serial_number: 'SYS-022', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 16, branch_id: 4, service_id: 11 )
Equipment.create( serial_number: 'SYS-023', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 17, branch_id: 4, service_id: 11 )
Equipment.create( serial_number: 'SYS-024', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 18, branch_id: 4, service_id: 11 )
Equipment.create( serial_number: 'SYS-025', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 19, branch_id: 5, service_id: 12 )
Equipment.create( serial_number: 'SYS-026', inspection_cycle_month: 36, inspection_contract: true, start_date: start_date_today, system_model_id: 5, place_id: 20, branch_id: 5, service_id: 12 )
Equipment.create( serial_number: 'SYS-027', inspection_cycle_month: 1, inspection_contract: true, start_date: start_date_today, system_model_id: 1, place_id: 21, branch_id: 5, service_id: 12 )
Equipment.create( serial_number: 'SYS-028', inspection_cycle_month: 2, inspection_contract: true, start_date: start_date_today, system_model_id: 2, place_id: 22, branch_id: 5, service_id: 12 )
Equipment.create( serial_number: 'SYS-029', inspection_cycle_month: 6, inspection_contract: true, start_date: start_date_today, system_model_id: 3, place_id: 23, branch_id: 5, service_id: 12 )
Equipment.create( serial_number: 'SYS-030', inspection_cycle_month: 12, inspection_contract: true, start_date: start_date_today, system_model_id: 4, place_id: 24, branch_id: 5, service_id: 12 )
