class Admin::BaseController < ApplicationController
  # Created one controller to rule them all ...
  #
  # This file can double as an eventual homepage for the admin namespace
  # and as a class that the other controllers inside the admin namespace
  # can inherit from.
  before_filter :authorize_admin!

  def index

  end
end
