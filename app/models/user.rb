class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  validates :email, presence: true
            # uniqueness: true
  # validates :nickname, presence: true

  def self.from_omniauth(auth)
    existing_user = User.find_by_email( auth.info.email )
    existing_user.fb_uid = auth.uid
    existing_user.fb_token = auth.credentials.token
    existing_user.save!
    return existing_user
  end
end
