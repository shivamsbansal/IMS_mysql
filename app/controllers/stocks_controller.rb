class StocksController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, only: [:update, :edit]
  before_filter :atleast_one_station
  
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

  def create
    begin
      @poDate= Date.new(params[:stock][:'poDate(1i)'].to_i, params[:stock][:'poDate(2i)'].to_i, params[:stock][:'poDate(3i)'].to_i)
    rescue ArgumentError
      @poDate=nil
    end
    begin
      @invoiceDate= Date.new(params[:stock][:'invoiceDate(1i)'].to_i, params[:stock][:'invoiceDate(2i)'].to_i, params[:stock][:'invoiceDate(3i)'].to_i)
    rescue ArgumentError
      @invoiceDate=nil
    end
    @warrantyPeriod = params[:warrantyPeriod].to_i.send(params[:warrantyPeriodType]).to_i
    if Item.find(params[:item_id]).assetType == 'consumable'
      @stock = Stock.new(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], presentStock: params[:initialStock], issuedReason: params[:issuedReason]  )
    else 
      @stock = Stock.new(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], presentStock: 0, issuedReason: params[:issuedReason]  )
    end
      
    if @stock.save
      flash[:success] = "Stock added"
      redirect_to stocks_path
    else
      render 'new'
    end
  end

  def index
  end

  def categoryList
    @category = params[:category]
    respond_to do |format|
      format.js
    end
  end

  def itemList
    result = user_access_stations(current_user)
    @item = Item.find(params[:item_id])
    if params[:station_id] == 'All'
      @stocks = []
      result[:stations].each do |station|
        @stocks = @stocks + station.stocks.where(item_id: params[:item_id])
      end
    else
      @stocks = Stock.where(item_id: params[:item_id], station_id: params[:station_id]) 
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    if current_user.admin?
      @disable = false
    else
      @disable = true
    end
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    if current_user.admin?
      @disable = false
      begin
        @poDate= Date.new(params[:stock][:'poDate(1i)'].to_i, params[:stock][:'poDate(2i)'].to_i, params[:stock][:'poDate(3i)'].to_i)
      rescue ArgumentError
        @poDate=nil
      end
      begin
        @invoiceDate= Date.new(params[:stock][:'invoiceDate(1i)'].to_i, params[:stock][:'invoiceDate(2i)'].to_i, params[:stock][:'invoiceDate(3i)'].to_i)
      rescue ArgumentError
        @invoiceDate=nil
      end
      @warrantyPeriod = params[:warrantyPeriod].to_i.send(params[:warrantyPeriodType]).to_i
      @stock.assign_attributes(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], issuedReason: params[:issuedReason]  )
    else
      @disable = true
      @stock.assign_attributes(presentStock: params[:presentStock])
    end
    if @stock.save
      flash[:success] = "Stock updated"
      redirect_to stocks_path
    else
      render 'edit'
    end
  end

  def present_stock_edit
    @stock = Stock.find(params[:id])
    @stocks = [@stock]
    @item = @stock.item
    if @stock.item.assetType == 'consumable'
      render 'consumableUpdate'
    else
      @asset = Asset.new
      render 'fixedUpdate'
    end
  end

  def present_stock_update
    @stock = Stock.find(params[:id])
    if @stock.item.assetType == 'consumable'
      @stock.presentStock = @stock.presentStock - params[:consumedStock].to_i
      if @stock.save
        flash[:success] = "Present Stock updated"
        redirect_to stocks_path
      else
        @stock.presentStock += params[:consumedStock].to_i
        @stocks = [@stock]
        @item = @stock.item
        render "consumableUpdate"
      end
    else
      @assetSrNo = params[:assetSrNo].split(/,\s*/)
      @assetSrNo.each do |serialNo|
        @asset = @stock.assets.build(assetSrNo: serialNo, issued: false)
        if @asset.save 
          @stock.presentStock = @stock.presentStock + 1
          @stock.save
        else
          @stocks = [@stock]
          @item = @stock.item
          render "fixedUpdate"
          return
        end
      end
      flash.now[:success] = "Present Stock updated"
      @assets = @stock.assets
      @item = @stock.item
      @stocks = [@stock]
      render 'assets/asset_list'
    end
  end

  def initialise_transfer_stock
    @stock = Stock.find(params[:id])
    @stocks = [@stock]
    @transfer = Transfers.new
    @item = @stock.item
    if @stock.item.assetType == 'consumable'
      render 'consumable_transfer'
    else
      @assets = @stock.assets
      render 'fixed_transfer'
    end
  end

  def transfer_stock
    begin
      @date= Date.new(params[:transfer][:'dateOfDispatch(1i)'].to_i, params[:transfer][:'dateOfDispatch(2i)'].to_i, params[:transfer][:'dateOfDispatch(3i)'].to_i)
    rescue ArgumentError
      @date=nil
    end
    @stock = Stock.find(params[:id])
    @transfer_stock = myclone(params[:id])
    if @stock.item.assetType == 'consumable'
      @quantity = params[:quantity].to_i
    else
      @quantity = params[:assets].size
    end
    @transfer_stock[:initialStock] = @quantity
    @transfer_stock[:presentStock] = @quantity
    @transfer_stock[:station_id] = params[:station_id]
    @transfer_stock[:inTransit] = true
    @stock.presentStock = @stock.presentStock - @quantity
    @transfer = Transfers.new(from: @stock.station_id, to: params[:station_id], dateOfDispatch: @date)
    if @stock.item.assetType == 'consumable'
      if ([@stock, @transfer_stock, @transfer].map(&:valid?)).all?
        @stock.save
        @transfer_stock.save
        @transfer[:stock_id] = @transfer_stock.id
        @transfer.save
        flash[:success] = "Stock Transferred"
        redirect_to stocks_path
      else
        @stock.presentStock += @quantity
        @stocks = [@stock]
        @item = @stock.item
        render 'consumable_transfer'
      end
    elsif @stock.item.assetType == 'fixed'
      if ([@stock, @transfer_stock, @transfer].map(&:valid?)).all?
        @stock.save
        @transfer_stock.save
        @transfer[:stock_id] = @transfer_stock.id
        @transfer.save
        params[:assets].each do |asset_id|
          @asset = Asset.find(asset_id)
          @asset.update_attributes(stock_id: @transfer_stock.id)
        end
        flash[:success] = "Stock Transferred"
        redirect_to stocks_path
      else
        @stock.presentStock += @quantity
        @stocks = [@stock]
        @assets = @stock.assets
        @item = @stock.item
        render 'fixed_transfer'
      end
    end
  end 

  def transfers_list
    @stations = user_access_stations(current_user)
    @stationList = @stations[:stations].map { |station| [station.nameStation, station.id]}
  end

  def station_transfers
    @station = Station.find(params[:station])
    @transfers_to = Transfers.where(to: params[:station], dateOfReceipt: nil)
    @transfers_from = Transfers.where(from: params[:station], dateOfReceipt: nil)
    respond_to do |format|
      format.js
    end
  end

  def acknowledge_receipt_stock
    @transfer = Transfers.find(params[:id])
    @stock = Stock.find(@transfer.stock_id)
    @stock[:inTransit] = false
    @transfer.dateOfReceipt = Date.today
    if ([@stock, @transfer].map(&:valid?)).all?
      @stock.save
      @transfer.save
      flash[:success] = "acknowledged"
      redirect_to '/transfers_list'
    else
      flash[:notice] = "error"
      redirect_to '/transfers_list'
    end
  end

  def show_stock
    @stock = Stock.find(params[:id])
    @stocks = [@stock]
    @item = @stock.item
  end

end
