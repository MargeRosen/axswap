class CategoriesController < ApplicationController
  before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :find_category, :only => [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Category has been created."
      redirect_to @category
    else
      flash[:alert] = "Category has not been created."
      render :action => "new"
    end
  end

  def show
    @listings = @category.listings.where(created_at: (DateTime.now - 7)..(DateTime.now + 1))
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category has been updated."
      redirect_to @category
    else
      flash[:alert] = "Category has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category has been deleted."
    redirect_to categories_path
  end

  private
    # def authorize_admin! moved to the application_controller.rb

    def find_category
      @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The category you were looking for could not be found."
      redirect_to categories_path
    end
end
