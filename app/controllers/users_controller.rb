class UsersController < ApplicationController
  before_action :authorize_request, :except => [:index, :new, :create]
  before_action :set_user, :only => [:edit, :update, :show, :destroy]

  # GET /users
  def index
    @users = User.all
    if @users.present?
      render json: @users, status: 200
    else
      render json: { message: 'No users exists.' }, status: 404
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 200
    else
      render json: { message: 'Unable to create User.' }, status: 400
      @user.errors.full_messages
    end
  end

  # GET users/:id/edit
  def edit
  end

  # PATCH /users/:id
  def update
    if @user.update_attributes(user_params)
      render json: { message: 'User updated successfully.' }, status: 200
    else
      render json: { message: 'Unable to update User.' }, status: 400
    end
  end

  # GET /user/:id
  def show
    if @user.present?
      render json: @user, status: 200
    else
      puts 'I am running.'
      render json: { message: 'Cannot find the user you are looking for.' }, status: 404
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      render json: { message: 'User destroyed successfully.' } , status: 200
    else
      render json: { message: 'Unable to destroy User.' }, status: 400
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Mass assignment and strong parameters
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
