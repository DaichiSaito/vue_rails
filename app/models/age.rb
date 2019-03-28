class Age < ActiveHash::Base
  include ActiveHash::Associations
  include ActiveModel::Serialization
  has_many :users
  self.data = [
      { id: 1, name: '20代' },
      { id: 2, name: '30代' },
      { id: 3, name: '40代' },
      { id: 4, name: '50代' },
      { id: 5, name: '60代' },
      { id: 6, name: '70代' },
  ]
end
