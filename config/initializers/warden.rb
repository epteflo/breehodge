Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = SessionsController
end

# Setup Session Serialization
class Warden::SessionSerializer
  def serialize(record)
    [record.class.name, record.id]
  end

  def deserialize(keys)
    klass, id = keys
    klass.constantize.find(:first, :conditions => { :id => id })
  end
end

Warden::Strategies.add(:password) do
  def valid?
    params[:username] && params[:password]
  end
  def authenticate!
    login = params[:username]
    password = params[:password]
    user = User.find_by_login(login)
    if user && user.authenticate(password)
      success!(user)
    else
      fail("auth_failed")
    end
  end
end