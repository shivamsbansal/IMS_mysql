class ItemsController < ApplicationController
  
  before_filter :signed_in_user 
	before_filter :admin_user

  def index
  	@items = Item.all
  	@itemCategory = Category.all.map { |category| [category.nameCategory, "/#{category.nameCategory}s"]}
  end

  def new
  	@itemCategory = Category.all.map { |category| [category.nameCategory, "/#{category.nameCategory}s/new"]}
  end

  def redirect
  	redirect_to params[:category]
  end
end
