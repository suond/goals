class SessionsController < ApplicationController
    def new
        @user = User.new
      end
    
      def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
         if @user
             log_in_user!(@user)
             redirect_to users_url
         else
             flash[:errors] = ["error logging in"]
             redirect_to new_session_url
         end
     end
    
      def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to new_session_url
      end
    
      private
    
      def user_params
        params.require(:user).permit(:username, :password)
      end
end
