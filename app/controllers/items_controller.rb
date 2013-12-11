class ItemsController < ApplicationController

  before_filter :load_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item
    @items = @items.where("name LIKE ? OR description LIKE ?", params[:search], params[:search]) unless params[:search].blank?
    @items = @items.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new item_params
    if @item.save
      redirect_to :items
    else
      render :new
    end
  end

  def update
    if @item.update_attributes item_params
      redirect_to @item
    else
      render :edit
    end
  end

  protected

    def load_item
      @item = Item.find params[:id]
    end

    def item_params
      params.require(:item).permit(:name, :description, :category_id)
    end

end
