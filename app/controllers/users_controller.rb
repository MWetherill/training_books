class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  def index
    @pagy, @users = pagy(:offset, User.kept.all.order(last_name: :asc))
    @users_total = User.kept.all.count
  end

  def show
    @user = User.find(params[:id])
    @pagy, @books = pagy(:offset, @user.books.order(title: :asc))

    activities = @user.activities
    @activities = activities.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entry }
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.discard
    redirect_to users_path, notice: "User destroyed"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :dob, :email_address)
  end
end
