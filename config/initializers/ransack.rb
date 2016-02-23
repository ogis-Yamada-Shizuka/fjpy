Ransack.configure do |config|
  config.add_predicate 'date_lteq',
  arel_predicate: 'lteq',
  formatter: proc { |v| v.to_date },
  validator: proc { |v| v.present? },
  type: :string
end
