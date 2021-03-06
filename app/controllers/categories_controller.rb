class CategoriesController < ApplicationController

  before_filter :load_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to :categories
    else
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      redirect_to @category
    else
      render :edit
    end
  end

  protected

    def load_category
      @category = Category.find params[:id]
    end

    def category_params
      params.require(:category).permit(:name)
    end

end
