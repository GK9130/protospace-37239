class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

    def index
      #@prototype = Prototype.includes(:user).order("created_at DESC")
      @prototype = Prototype.includes(:user)
    end
  
    def new
      @prototype = Prototype.new
    end
  
    def create
      @prototype = Prototype.new(prototype_params)
        if @prototype.save
          redirect_to root_path
        else
          render :new
        end
    end
  
    def destroy
      if @prototype.destroy
        redirect_to root_path
      else
        redirect_to root_path
      end
    end
  
    def edit
      
    end
  
    def update
      if @prototype.update(prototype_params) 
        redirect_to prototype_path(@prototype)
      else
        render :edit
      end
    end
  
    def show
      @comment = Comment.new
      @comments = @prototype.comments
    end
  
    def search
      @prototype = Prototype.search(params[:keyword])
    end
  
    private
  
    def prototype_params
      params.require(:prototype).permit(:image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
    end
  
    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def contributor_confirmation
      redirect_to root_path unless current_user == @prototype.user
    end
end