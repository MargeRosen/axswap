class ListingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_category
  before_filter :find_listing, :only => [:show, :edit, :update, :destroy]


  def new
    @listing = @category.listings.build
    #@listing.assets.build
  end

  def edit
    @listing
  end

  def create

    @listing = @category.listings.build(params[:listing])
    @listing.user = current_user
    if @listing.save
      flash[:notice] = "Your listing has been created."
      redirect_to [@category, @listing]
    else
     flash[:alert] = "Listing has not been created."
     render :action => "new"
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def update
    if @listing.update_attributes(params[:listing])
      flash[:notice] = "Listing has been updated."
      redirect_to [@category, @listing]
    else
      flash[:alert] = "Listing has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    flash[:notice] = "Listing has been deleted."
    redirect_to @category
  end

  private
  def find_category
    @category = Category.find(params[:category_id])
  end

  def find_listing
    @listing = @category.listings.find(params[:id])
  end
end
