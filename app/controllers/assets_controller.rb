class AssetsController < ApplicationController
	before_filter :signed_in_user

  def asset_list
    @stock = Stock.find(params[:id])
    @assets = @stock.assets
    @item = @stock.item
    @stocks = [@stock]
  end

  def issue_asset
    @asset = Asset.find(params[:id])
    @stock = @asset.stock
    @station = @stock.station
    @associates = @station.associates
  end

  def issueAsset
    begin
      @date= Date.new(params[:issued_item][:'dateOfIssue(1i)'].to_i, params[:issued_item][:'dateOfIssue(2i)'].to_i, params[:issued_item][:'dateOfIssue(3i)'].to_i)
    rescue ArgumentError
      @date=nil
    end
    @issued_item = IssuedItem.new(asset_id: params[:asset_id], associate_id: params[:associate_id], dateOfIssue: @date)

    @asset = Asset.find(params[:asset_id])
    @asset.issued = true

    @stock = @asset.stock
    @stock.presentStock = @stock.presentStock - 1

    if ([@stock, @asset, @issued_item].map(&:valid?)).all?
      @stock.save
      @asset.save
      @issued_item.save
      flash[:success] = "Successfully issued"
    else
      flash[:error] = "Unsuccessfull issue"
    end
    redirect_to "/asset_list/#{@stock.id}"
  end

  def issued_list
    @associate = Associate.find(params[:id])
    @assets = @associate.assets
  end

  def destroy
  	@asset = Asset.find(params[:id])
  	@stock = @asset.stock
    if @asset.issued != true
  	 @stock.presentStock = @stock.presentStock - 1
  	end
    @stock.save
  	@asset.destroy
    flash[:success] = "Asset destroyed."
    redirect_to "/asset_list/#{@stock.id}"
  end

  def withdraw_asset
    @asset = Asset.find(params[:id])
    @stock = @asset.stock
    @stock.presentStock = @stock.presentStock + 1
    @stock.save
    @asset.issued = false
    @asset.save
    @asset.issued_item.destroy
    flash[:success] = "Asset withdrawn."
    redirect_to "/asset_list/#{@stock.id}"
  end

end
