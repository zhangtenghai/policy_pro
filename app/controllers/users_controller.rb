class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :export]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def query(params)
    users = User.quick_search(params[:search])
    users = users.where("created_at >= ?", params[:begin_at].to_datetime) if !params[:begin_at].blank?
    users = users.where("created_at <= ?", params[:end_at].to_datetime) if !params[:end_at].blank?
    users = users.where(province: params[:province]) if !params[:province].blank?
    users = users.where(city: params[:city]) if !params[:city].blank?
    users = users.where(district: params[:district]) if !params[:district].blank?
    users = users.order("id desc")
    users
  end
  # GET /users
  # GET /users.json
  def index
    @users = query(params).page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def export
    send_data query(params).to_csv, filename: "users.csv"
  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to success_users_path, notice: '成功录入 谢谢！' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :address, :province, :city, :district, :street)
    end
end
