class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i(google facebook twitter)

         belongs_to :citicize, optional: true
         has_many :comments, dependent: :destroy
         has_many :citicizes, dependent: :destroy
         has_many :estimates, dependent: :destroy
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_google(auth)
  user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(email:      auth.info.email,
                      image_url:  auth.info.image,
                      provider:   auth.provider,
                      name:       auth.info.name,
                      uid:        auth.uid,
                      password:   Devise.friendly_token[0, 20],
                      )
    end
  user.save
  user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(provider:   auth.provider,
                      uid:        auth.uid,
                      name:       auth.info.name,
                      image_url:  auth.info.image,
                      email:      "#{auth.uid}-#{auth.provider}@example.com",
                      password:   Devise.friendly_token[0, 20]
      )
    end
    user.save
    user
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    unless user
      user = User.new(provider:  auth.provider,
                      uid:       auth.uid,
                      name:      auth.extra.raw_info.name,
                      image_url: auth.info.image,
                      email:     "#{auth.uid}-#{auth.provider}@example.com",
                      password:  Devise.friendly_token[0, 20]
      )
    end

    user.save
    user
  end
end
