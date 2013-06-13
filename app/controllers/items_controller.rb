class ItemsController < ApplicationController
  
  before_filter :signed_in_user 
	before_filter :admin_user, except: [:index, :list]

  def index
  	@itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}
  end

  def new
  	@itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}
  end

  def redirect
    @item = Item.new
  	@category = params[:category]
    respond_to do |format|
      format.js
    end
  end

  def create
    item_hash = {nameItem: params[:item][:nameItem], codeItem: params[:item][:codeItem], cost: params[:item][:cost], lifeCycle: params[:item][:lifeCycle], leadTime: params[:item][:leadTime],minimumStock: params[:item][:minimumStock], vendor_id: params[:item][:vendor_id] }
    @itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}

    @categoryItem = params[:category].capitalize.constantize.new(params[:item][params[:category].to_s])
    if @categoryItem.valid?
      @item = @categoryItem.items.new(item_hash)
      if @item.valid?
          @categoryItem.save
          @item.save
          redirect_to items_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def list
    @category = params[:category]
    @list = Item.where(itemCategory_type: @category.capitalize)
    respond_to do |format|
      format.js
    end
  end

end
