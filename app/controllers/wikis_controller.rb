class WikisController < ApplicationController
    def index
        @wikis = policy_scope(Wiki)
    end
    
    def new
        @wiki = Wiki.new
    end
    
    def create
        @wiki = Wiki.new
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]
        @wiki.user_id = current_user.id
        
        if @wiki.save
            flash[:notice] = "Wiki was saved successfully!"
            redirect_to @wiki
        else
            flash[:alert] = "There was an error saving the wiki. Please try again."
            render :new
        end
    end
    
    def show
        @wiki = Wiki.find(params[:id])
    end
    
    def edit
        @wiki = Wiki.find(params[:id])
    end
    
    def update
        @wiki = Wiki.find(params[:id])
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.private = params[:wiki][:private]
        if @wiki.save
            flash[:notice] = "Wiki was saved successfully!"
            redirect_to @wiki
        else
            flash[:alert] = "There was an error saving the wiki. Please try again."
            render :edit
        end
    end
    
    def destroy
        @wiki = Wiki.find(params[:id])
        if @wiki.destroy
            flash[:notice] = "The wiki was deleted successfully."
            redirect_to action: :index
        else
            flash[:alert] = "There was an error deleting the wiki. Please try again."
            render :show
        end
    end
    
    def collaborator
        @wiki = Wiki.find(params[:wiki_id])
    end
    
    def add
        @user = User.where(email: params[:user_email]).first
        @wiki = Wiki.find(params[:wiki_id])
        if User.exists?(:email => params[:user_email])
            @collaborator = Collaborator.new
            @collaborator.user_id = @user.id
            @collaborator.wiki_id = @wiki.id
            
            if @collaborator.save
                flash[:notice] = "You can now collaborate with #{@user.email} on this wiki!"
                redirect_to @wiki
            else
                flash[:alert] = "You might have added this collaborator already. Please try again."
                render :show
            end
        else
            flash[:alert] = "That's not a valid email. Please try again."
            render :show
        end
    end
    
    def collaborator_remove
        @wiki = Wiki.find(params[:wiki_id])
    end
    
    def remove
        @user = User.where(email: params[:user_email]).first
        @wiki = Wiki.find(params[:wiki_id])
        @collaborators = Collaborator.where("user_id = ? AND wiki_id = ?", @user.id, @wiki.id).first
        
        if @collaborators.destroy
            flash[:notice] = "#{@user.email} can no longer work on this wiki."
            redirect_to @wiki
        else
            flash[:alert] = "There was an error deleting the collaborator. Please try again."
            render :show
        end
    end
end
