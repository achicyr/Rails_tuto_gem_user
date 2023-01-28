class Post < ApplicationRecord
  belongs_to :user

  attr_accessor :country # C'EST JUSTE POUR UN TEST CONCERNANT LE GEM country_select

  validates :name, presence: true
end
