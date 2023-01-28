class User < ApplicationRecord

  attr_accessor :login
  
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with:/\A[a-zA-Z0-9 _\.]*\Z/}
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :trackable
  devise :omniauthable, omniauth_providers: [:github, :google]


  def self.find_first_by_auth_conditions(warden_conditions)
    # puts "===="
    # puts warden_conditions.inspect
    # puts "===="
    conditions = warden_conditions
    if login = conditions.delete(:login)
      a=where(conditions.to_hash).where("lower(username) = :value or lower(email) = :value", value: login.downcase).first
      puts "if"
      puts a.inspect
      a
    else
      a=where(conditions.to_hash).first
      puts "else"
      puts a.inspect
      a
    end
  end

  def self.from_facebook(auth)
    where(facebook_id: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end
  
end