class WikisController < ApplicationController
    def index
        @wikis = Wiki.all
    end
    
    def new
        @wiki = Wiki.new
    end
    
    def create
        @wiki = Wiki.new
        @wiki.title = params[:wiki][:title]
        @wiki.body = params[:wiki][:body]
        @wiki.user = current_user
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
end
