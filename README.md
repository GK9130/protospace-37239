# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

## rooms テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :room_users
- has_many :users, through: :room_users
- has_many :messages

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## messages テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]
  

    def index
      #@prototype = Prototype.includes(:user).order("created_at DESC")
      @prototype = Prototype.all
    end
  
    def new
      @prototype = Prototype.new
    end
  
    def create
      Prototype.create(prototype_params)
    end
  
    def destroy
      prototype = Prototype.find(params[:id])
      Prototype.destroy
    end
  
    def edit
    end
  
    def update
      prototype = Prototype.find(params[:id])
      Prototype.update(prototype_params)
    end
  
    def show
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
    end
  
    def search
      @prototype = Prototype.search(params[:keyword])
    end
  
    private
  
    def prototype_params
      params.require(:prototype).permit(:image, :text).merge(user_id: current_user.id)
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