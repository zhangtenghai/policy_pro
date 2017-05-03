class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:login]

  def login=(login)
    @login = login
  end

  def login
    unless @login
      if self.name
        self.name
      else
        self.email
      end
    else
      @login
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["(lower(name) = :value OR lower(email) = :value)", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
