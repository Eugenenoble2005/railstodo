class User < ApplicationRecord
    has_secure_password
    validates :username, length: { minimum:5},uniqueness: true
    validates :password_digest, length: { minimum:5, too_short: "should be atleast 5 characters long"}

end
