class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :wikis, dependent: :destroy
  
  after_initialize { self.role ||= :standard }
  
  after_commit :assign_customer_id, on: :create
  
  enum role: { standard: 0, premium: 1, admin: 2 }
  
  def assign_customer_id
    customer = Stripe::Customer.create(email: email)
    self.customer_id = customer.id
  end
  
  def make_wikis_public
    puts "This user's ID is: #{self.id}"
    @wikis = Wiki.where(user_id: self.id).all
    @wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
  end
end
