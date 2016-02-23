class Branch < Company
  has_many :services
  has_many :places
end
