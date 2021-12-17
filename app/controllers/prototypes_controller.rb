class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :update, :show]
  before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!, only: [:edit, :delete]

    def index
      #@prototype = Prototype.includes(:user).order("created_at DESC")
      @prototype = Prototype.all
      @prototype = Prototype.includes(:user)
    end
  
    def new
      @prototype = Prototype.new
    end
  
    def create
      @prototype = Prototype.new(prototype_params)
        if @prototype.save
          redirect_to prototype_path
        else
          render :show
        end
    end
  
    def destroy
      prototype = Prototype.find(params[:id]) 
      if prototype.destroy
        redirect_to root_path
      else
        render :show 
      end
    end
  
    def edit
      
    end
  
    def update
      @prototype.update(prototype_params)
      if @prototype.save
        redirect_to prototype_path
      else
        render :edit
      end
    end
  
    def show
      @user = User.new  
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
    end
  
    def search
      @prototype = Prototype.search(params[:keyword])
    end
  
    private
  
    def prototype_params
      params.require(:prototype).permit(:name,:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
    end
  
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def move_to_index
      unless user_signed_in?
        redirect_to action: :index
      end
    end
 
end