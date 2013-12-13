class ItemsController < ApplicationController

  before_filter :load_item, only: [:show, :edit, :update, :destroy, :post_to_ebay]
  before_filter :load_categories, only: [:new, :edit]

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
      load_categories
      render :new
    end
  end

  def update
    if @item.update_attributes item_params
      redirect_to @item
    else
      load_categories
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to :items
    else
      render :show
    end
  end

  def post_to_ebay
    if @item.list
      redirect_to @item
    else
      load_categories
      render :show
    end
  end

  protected

    def load_item
      @item = Item.find params[:id]
    end

    def load_categories
      @categories = Category.where.not(parent_id: nil).select{|c| !c.sub_categories.empty?}
    end

    def item_params
      params.require(:item).permit(:name, :description, :category_id, :price)
    end

end
