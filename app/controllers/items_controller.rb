class ItemsController < ApplicationController
  
  before_filter :signed_in_user 
	before_filter :admin_user, except: [:index, :list, :details]

  def index
  	@itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}
    @itemCategory = @itemCategory + [['All', 'All']]
  end

  def new
  	@itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}
  end

  def edit
    @item = Item.find(params[:id])
    @category = @item.itemCategory_type
  end

  def update
     item_hash = {nameItem: params[:item][:nameItem], codeItem: params[:item][:codeItem], cost: params[:item][:cost], lifeCycle: params[:item][:lifeCycle], leadTime: params[:item][:leadTime],minimumStock: params[:item][:minimumStock], assetType: params[:item][:assetType], vendor_id: params[:item][:vendor_id] }
    @itemCategory = Category.all.map { |category| [category.nameCategory, category.nameCategory]}

    @categoryItem = Item.find(params[:id]).itemCategory
    @category = Item.find(params[:id]).itemCategory_type
    @categoryItem.assign_attributes(params[:item][params[:category].downcase.to_s])
    if @categoryItem.valid?
      @item = Item.find(params[:id])
      @item.assign_attributes(item_hash)
      if @item.valid?
          @categoryItem.save
          @item.save
          redirect_to items_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @itemCategory = @item.itemCategory
    @item.destroy
    @itemCategory.destroy
    flash[:success] = "Item deleted."
    redirect_to items_url
  end

  def redirect
    @item = Item.new
  	@category = params[:category]
    respond_to do |format|
      format.js
    end
  end

  def details
    if params[:id] !=0
      @details = Item.find(params[:id]).itemCategory
    end
  end

  def create
    item_hash = {nameItem: params[:item][:nameItem], codeItem: params[:item][:codeItem], cost: params[:item][:cost], lifeCycle: params[:item][:lifeCycle], leadTime: params[:item][:leadTime],minimumStock: params[:item][:minimumStock], assetType: params[:item][:assetType], vendor_id: params[:item][:vendor_id] }
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
    if @category != 'All'
      @list = Item.where(itemCategory_type: @category.capitalize)
    else
      @list = Item.all
    end
    respond_to do |format|
      format.js
    end
  end

end
