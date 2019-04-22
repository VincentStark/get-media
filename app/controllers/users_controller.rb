class UsersController < ApplicationController
  before_filter :signed_in_user, only: [ :index, :update ] 
  before_filter :admin_user, only: [ :index, :update ] 
  before_filter :correct_user, only: [ :update ]

  def index
    # Toggle sorting
    if session[:sort_user] == params[:sort] && !params[:sort].nil?
      sort = session[:sort_user] + ' DESC'
      session[:sort_user] = sort
    else
      sort = process_param(:sort, :sort_user, 'email')
    end
    page = process_param(:page, :page_user)

    # Special sorting cases
    if sort.include?('downloads_total')
      users_scope = User.downloads_count
    else
      users_scope = User
    end

    # ", id ASC" is used to maintain sorting order
    @users = users_scope.order(sort + ', users.id ASC').paginate(:page => page)
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    if !@user.save(:validate => false)
      @ajax_error = @user.error.full_message
    end
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js { render 'shared/ajax-progress' }
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      UserMailer.confirm_email(@user).deliver
      flash[:success] = "Welcome to the GetMedia!"
      redirect_to downloads_path
    else
      render 'static_pages/login'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def confirm
    @user = User.find_by_remember_token(params[:confirm_id])
    if !@user.nil?
      if !@user.is_confirmed?
        flash.now[:success] = @user.email + " is confirmed."
        @user.is_confirmed = 1
        @user.save(:validate => false)
      else
        flash.now[:warning] = @user.email + " is already confirmed."
      end
    else
      flash.now[:error] = "No such user to confirm."
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      if current_user?(@user)
        @ajax_error = "You can't change attributes for yourself." if current_user?(@user)
        render 'users/update'
      end
    end
end
