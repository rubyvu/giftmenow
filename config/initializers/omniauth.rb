Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :twitter, 'LdgZncsnpChWANf4FsJdQ', 'bvPEv8KmMTXwRsLZRjP7Vr4wpTNRcKs9ssYbV41pkE'
  provider :facebook, "411272352225938", "7ac2ee1936092a62033198133a0cdbc6"
  #provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  #provider :openid, OpenID::Store::Filesystem.new('/tmp'), :name => 'yahoo', :identifier => "https://me.yahoo.com"
end
