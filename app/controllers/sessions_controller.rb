class SessionsController < ApplicationController
  skip_before_filter :authenticate!, only: [:unauthenticated, :new]

  def new
    redirect_to root_url if env['warden'].user
  end

  def create
    redirect_to root_url
  end

  def unauthenticated
    flash[:error] = warden.message
    redirect_to login_path
  end

  def destroy
    env['warden'].logout
    redirect_to home_url
  end

  def user
    render json: current_user
    end
end
