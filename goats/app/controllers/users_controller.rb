class UsersController < ApplicationController

    def index
        render :index
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            log_in_user!(@user)
            redirect_to users_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
