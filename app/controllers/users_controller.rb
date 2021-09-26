class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    @tasks = Task.where(user_id: signed_in_user.id) if is_auth
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end
  def new_session
    username = params[:username]
    password_digest = params[:password]
     respond_to {
       |format|
       @user = User.find_by(username: username)
       if @user && @user.authenticate(password_digest)
        session[:user_id] = @user.id
          format.html {redirect_to "/"}
       else
        @error = "Invalid login credenetials"
        format.html { render :login}
       end
     }

  end
  # GET /users/1/edit
  def edit
  end

  def logout
    auth_guard
    session[:user_id] = nil
    redirect_to "/"
  end
  # POST /users or /users.json
  def create
   username = params[:username]
   password = params[:password]
   @user = User.new(username: username, password: password)
    respond_to {
      |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to "/"}
      else
        format.html { render :new}
       end
      }
  end 

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
