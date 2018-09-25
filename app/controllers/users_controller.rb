class UsersController < ApplicationController


  def index
    @users = User.paginate(page: params[:page],per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @user_novels = @user.novels.paginate(page: params[:page], per_page: 5)
  end

end
