class User < ActiveRecord::Base
  has_many :emails
  has_many :good_prescriptions
  has_many :bad_prescriptions
end
