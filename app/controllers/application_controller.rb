# typed: false
class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_path
  end
end
