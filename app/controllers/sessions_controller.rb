class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({ "username" => params["username"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        redirect_to "/"
      else
        flash["notice"] = "Oy garbanzo, invalid username or password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Oy garbanzo, invalid username or password."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "See you next time!"
    redirect_to "/login"
  end
end