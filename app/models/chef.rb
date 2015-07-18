class Chef < ActiveRecord::Base
    has_many :recipes
    has_many :likes
    before_save { self.email = email.downcase }
    validates :chefname, presence: true, length: { minimum: 10, maximum: 40 }
    VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    validates :email, presence: true, length: { minimum: 10, maximum: 100 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
end
