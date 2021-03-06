class User < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie


  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :username, presence: true,
                     format: /\A[A-Z0-9]+\z/i,
                     uniqueness: { case_sensitive: false }




   # User level scopes

   scope :by_name, -> { order(:name) }
   scope :not_admins, -> { by_name.where(admin: false) }


def self.authenticate(email, password)
  user = User.find_by(email: email)
  user && user.authenticate(password)
end



 def gravatar_id
   Digest::MD5::hexdigest(email.downcase)
 end

end
