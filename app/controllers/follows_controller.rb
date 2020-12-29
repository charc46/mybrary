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
    follow = Follow.new(follower_id: current_user.id, followee_id: params[:id])
    if follow.save
      redirect_to follows_path
      flash[:notice] = "New following!"
    else
      render :index
      flash[:alert] = "Oops, something went wrong!"
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy
    redirect_to follows_path
  end
end
