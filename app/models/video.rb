class Video < ApplicationRecord
  validates_uniqueness_of :title, :case_sensitive => false
end
