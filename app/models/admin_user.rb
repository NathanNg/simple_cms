class AdminUser < ActiveRecord::Base

  has_secure_password

  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  #constant
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary']

  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25

validates :first_name, :presence => true,
                      :length => {:maximum => 25}

  validates :email, :presence => true,
                    :length => {:maximum => 25}

  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50

  validates :last_name, :presence => true,
                        :length => {:maximum => 50}

  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username

  validates :username, :presence => true,
                       :length => {:within => 8..25},
                       :uniqueness => true

  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  validates :email, :presence => true,
                    :length => {:maximum => 100},
                    :format => EMAIL_REGEX,
                    :confirmation => true

  #To configure a different table name:
  #since we change to table name from "users" to "admin_user"
  #self.table_name = "admin_users"

validate :username_is_allowed
#validate :no_new_users_on_saturday, :on => :create

def name
  "#{first_name} #{last_name}"
  # or first_name + ' ' + last_name
  # or [first_name, last_name].join(' ')
end

scope :sorted, lambda { order("admin_users.last_name ASC, admin_users.first_name ASC ")}

private

 def username_is_allowed
   if FORBIDDEN_USERNAMES.include?(username)
    errors.add(:username, "has been restricted from use.")
    end
  end

  # def no_new_users_on_saturday
  #   if Time.now.wday === 6
  #     errors[:base] << "No new users on Saturday"
  #   end
  # end


end
