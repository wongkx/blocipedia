class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        
        if @user.save
            flash[:notice] = "Welcome to Blocipedia, #{@user.name}!"
            redirect_to root_path
        else
            flash.now[:alert] = "There was an error creating your account. Please try again."
            render :new
        end
    end
    
    def downgrade
        @user = User.find(params[:user_id])
        @user.role = "standard"
        
        if @user.save
            flash[:notice] = "You have been downgraded, #{@user.email}"
            redirect_to root_path
        else
            flash.now[:alert] = "There was an error downgrading your profile. Please try again."
            render :new
        end
    end
        
    # def show
    #     @user = User.find(params[:id])
    # end
end
