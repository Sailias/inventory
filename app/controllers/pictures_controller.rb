class PicturesController < ApplicationController

  before_filter :load_item
  before_filter :load_picture, only: [:show, :destroy]

  def new
    @picture = @item.pictures.new
  end

  def create
    @picture = @item.pictures.new picture_params
    if @picture.save
      redirect_to @item
    else
      render :new
    end
  end

  def destroy
    if @picture.destroy
      redirect_to @item
    else
      render :show
    end
  end

  protected

  def load_item
    @item = Item.find params[:item_id]
  end

  def load_picture
    @picture = @item.pictures.find params[:id]
  end

  def picture_params
    params.require(:picture).permit(:image)
  end

end
