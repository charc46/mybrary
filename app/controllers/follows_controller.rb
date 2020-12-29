class FollowsController < ApplicationController
  def index
    if params[:q]
      sql_query = "email ILIKE :q"
      @users = User.where(sql_query, q: "%#{params[:q]}%").paginate(page: params[:page], per_page: 10)
    else
      @followers = current_user.followers
      @followings = current_user.followees
    end
  end
  
  def create
  end

  def delete
  end
end
