class UserapiController < ActionController::API
  def signin
    email = params["email"]
    password = params["password"]
    user = User.find_by_email(email)
    verified = user.valid_password?(password)

    if verified
      data = {}
      data["message"] = "You are signed in!"
      user.accesstoken = SecureRandom.hex
      user.save
      data["accesstoken"] = user.accesstoken
      render json: data
    elsif !verified
      data = {}
      data["message"] = "Wrong password!"
      render json: data
    end
  end

  def signup
    u = User.new
    email = params["email"]
    password = params["password"]
    data = {}
    if User.find_by_email(email)
      data["message"] = "User already exists, please sign-in"
      render json: data
    else
      u = User.new
      u.email = email
      u.password = password
      u.accesstoken = nil
      u.save
      data["message"] = "existing account with email ID: #{email}"
      render json: data
    end
  end

  def logout
    current_user.accesstoken = nil
    current_user.save
    data = {}
    data["message"] = "Signed out successfully!"
    render json: data
  end
end
