class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  respond_to :html

  def index
    @categories = Category.paginate(page: params[:page], per_page: 20)

    respond_with(@categories)
  end

  def new
    @category = Category.new

    respond_with(@category)
  end

  def create
    @category = Category.new(category_params)
 
    respond_with(@category) do |format|
      if @category.save
        flash[:notice] = "Category successfully created."
        format.html { redirect_to category_path(@category) }
      else
        flash[:error] = "Sorry, failed to create category due to errors."
        format.html { render 'new' }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_with(@category) do |format|
      if @category.update(category_params)
        flash[:notice] = "Category successfully updated."
        format.html { redirect_to category_path(@category) }
      else
        flash[:error] = "Sorry, failed to update category due to errors."
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @category.destroy

    flash[:notice] = "Category has been deleted."
    respond_with(@category)
  end
 
 private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end