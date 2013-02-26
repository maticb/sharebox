class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  validates :email, :presence => true, :uniqueness => true

  has_many :assets
  has_many :folders


  #this is for folders which this user has shared
  has_many :shared_folders, :dependent => :destroy

  #this is for folders which the user has been shared by other users
  has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy

end
