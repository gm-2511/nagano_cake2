class Admin::ItemsController < ApplicationController
  # 管理者のみアクセス可能
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_genres, only: [:new, :edit, :create, :update]

  def index
    #@items = Item.includes(:genre).page(params[:page])
    @items = Item.order(:id).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を更新しました"
    else
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_genres
    @genres = Genre.all
  end

  def item_params
    params.require(:item).permit(:name, :price, :genre_id, :introduction, :image, :is_active)
  end
end

