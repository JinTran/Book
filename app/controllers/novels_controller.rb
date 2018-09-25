class NovelsController < ApplicationController

  # before_action :authenticate_user!

  load_and_authorize_resource
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  before_action :set_novel, only: [:edit, :update, :show, :destroy]
  # before_action :require_user, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @novels = Novel.paginate(page: params[:page],per_page: 5)
  end

  def show

  end

  def new
    @novel = Novel.new
  end

  def edit
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.user = current_user
    if @novel.save
      flash[:success] = 'novel was successfully created'
      redirect_to @novel
    else
      render 'new'
    end
  end

  def update
    if @novel.update(novel_params)
      flash[:success] = 'novel was successfully created'
      redirect_to @novel
    end
  end

  def destroygit init
    @novel.destroy
    flash[:danger] = "novel was successfully deleted"
    # respond_to do |format|
    #   format.html {redirect_to novels_url,notice: "deleted"}
    #   format.json {head :no_content}
    #   format.js
    # end

    redirect_to novels_path
  end



  def search
    if params[:novel].blank?
      flash.now[:danger] = "empty string"
    else
      @novels_search = Novel.search(params[:novel])
      flash.now[:danger] = "no user matches" if @novels_search .blank?
    end
    # render json: @novels_search
      respond_to do |format|
      format.js {render partial: 'novels/result'}
    end
  end



  private

  def set_novel
    @novel = Novel.find(params[:id])
  end


  def novel_params
    params.require(:novel).permit(:name, :publisher,:description,:image)
  end

  def require_same_user
    if current_user != @novel.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own novel"
      redirect_to root_path
    end
  end
end

