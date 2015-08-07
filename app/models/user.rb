# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:login]

   # Virtual attribute for authenticating by either username or email
   # This is in addition to a real persisted field like 'username'
   attr_accessor :login
   has_many :items

   def self.find_for_database_authentication(warden_conditions)
       conditions = warden_conditions.dup
       if login = conditions.delete(:login).downcase
          where(conditions.to_hash).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
       else
          where(conditions.to_hash).first
       end
     end


   def self.send_reset_password_instructions(attributes={})
     recoverable = find_or_initialize_with_errors([:email], attributes, :not_found)
     recoverable.send_reset_password_instructions if recoverable.persisted?
     recoverable
   end



end
