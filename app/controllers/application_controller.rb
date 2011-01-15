class ApplicationController < ActionController::Base
  include PostsHelper

  protect_from_forgery
end
