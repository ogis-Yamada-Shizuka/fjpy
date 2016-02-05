class Service < Company
  has_many :inspection_requests
  belongs_to :branch
end
