class StocksController < ApplicationController
  def new
  	@stock =Stock.new
  end

  def choice
    @category = params[:category]
    if @category != 'All'
      @list =Item.where(itemCategory_type: @category.capitalize)
    else
      @list = Item.all
    end
    respond_to do |format|
      format.js
    end
  end

end
