class Authentication < ActiveRecord::Base
  belongs_to :user

  def self.create_from_hash(hash)
    password = ActiveSupport::SecureRandom.base64(8) 
    
    user = User.create!(
      :email => hash['user_info']['email'],
      :password => password,
      :user_name => "#{hash['user_info']['first_name']} #{hash['user_info']['last_name']}"
    )      
    Authentication.create(:user_id => user.id, :uid => hash['uid'], :provider => hash['provider'])    
    user
  end
end
