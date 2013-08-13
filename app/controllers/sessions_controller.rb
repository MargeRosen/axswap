# OmniAuth for Twitter
class SessionsController < ApplicationController
  def create
    #raise env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
  end
end
