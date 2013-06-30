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
    if can_access_station(Station.find(params[:station_id])) == false
      return
    end
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
      @stock = Stock.new(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], presentStock: params[:initialStock],  comments: params[:comments]  )
    else 
      @stock = Stock.new(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], presentStock: 0,  comments: params[:comments]  )
    end
      
    if @stock.save
      flash[:success] = "Stock added"
      if @stock.item.assetType == 'fixed'
        flash[:notice] = "Update The Serial Numbers of assets for the stock added"
      end
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
    if params[:item_id] != 'All'
      @item = Item.find(params[:item_id])
      if params[:station_id] == 'All'
        @stocks = []
        result[:stations].each do |station|
          @stocks = @stocks + station.stocks.where(item_id: params[:item_id])
        end
      else
        @stocks = Stock.where(item_id: params[:item_id], station_id: params[:station_id]) 
      end
    else
      @item = nil
      if params[:station_id] == 'All'
        @stocks = []
        result[:stations].each do |station|
          @stocks = @stocks + station.stocks
        end
      else
        @stocks = Stock.where(station_id: params[:station_id]) 
      end
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
      @stock.assign_attributes(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock]  )
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
    if can_access_station(@stock.station) == false
      return
    end
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
    if can_access_station(@stock.station) == false
      return
    end
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
    if can_access_station(@stock.station) == false
      return
    end
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
    
    if can_access_station(@stock.station) == false
      return
    end
    if @stock.station.id == params[:station_id].to_i
      flash[:notice] = "Stock cannot be transferred to same Station"
      redirect_to "/initialise_transfer_stock/#{params[:id]}"
      return
    end
    @transfer_stock = myclone(params[:id])
    if @stock.item.assetType == 'consumable'
      @quantity = params[:quantity].to_i
    elsif @stock.item.assetType == 'fixed' &&params[:assets] != nil
      @quantity = params[:assets].size
    else
      flash[:notice] = "No assets to transfer"
      redirect_to "/asset_list/#{params[:id]}"
      return
    end

    @transfer_stock[:initialStock] = @quantity
    @transfer_stock[:presentStock] = @quantity
    @transfer_stock[:station_id] = params[:station_id]
    @transfer_stock[:inTransit] = true
    @transfer_stock[:comments] = params[:comments]

    @stock.presentStock = @stock.presentStock - @quantity
    @transfer = Transfers.new(from: @stock.station_id, to: params[:station_id], dateOfDispatch: @date, comments: params[:comments])
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
    if can_access_station(@station) == false
      return
    end
    @transfers_to = Transfers.where(to: params[:station], dateOfReceipt: nil)
    @transfers_from = Transfers.where(from: params[:station], dateOfReceipt: nil )
    respond_to do |format|
      format.js
    end
  end

  def acknowledge_receipt_stock
    @transfer = Transfers.find(params[:id])
    @stock = Stock.find(@transfer.stock_id)
    if can_access_station(@stock.station) == false
      return
    end
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
    if can_access_station(@stock.station) == false
      return
    end
    @stocks = [@stock]
    @item = @stock.item
  end

  def total_costs
    @stations = user_access_stations(current_user)[:stations]
  end

  def stations_cost
    @station_cost = [] 
    @items = Item.all
    if params[:stations] != nil
      @stations = Station.find(params[:stations])
      @stations.each do |station|
        if can_access_station(station) == false
          return
        end
        @total_cost = []
        @items.each do |item|
          @stocks = station.stocks.where(inTransit: false, item_id: item.id)
          @cost = 0
          if @stocks != []
            @stocks.each do |stock|
              @cost += stock.presentStock * stock.item.cost
            end
            @total_cost += [[item,@cost]]
          end
        end
        @station_cost += [[station,@total_cost]]
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def alerts_minimum
    @stations = user_access_stations(current_user)[:stations] 
    @items = Item.all
    @minimum_stocks = []
    @stations.each do |station|
      if can_access_station(station) == false
        return
      end
      @items.each do |item|
        @stocks = station.stocks.where(inTransit: false, item_id: item.id)
        if @stocks != []
          @presentStock = 0
          @stocks.each do |stock|
            @presentStock += stock.presentStock
          end
          if item.minimumStock > @presentStock
            @minimum_stocks += [[item,@presentStock,station]]
          end
        end
      end
    end
  end

  def alerts_lifecycle
    @stations = user_access_stations(current_user)
    @stationList = @stations[:stations].map { |station| [station.nameStation, station.id]}
  end

  def calculate_lifecycle_alerts
    @goes = false
    begin
      @dateEnd= Date.new(params[:alert][:'dateEnd(1i)'].to_i, params[:alert][:'dateEnd(2i)'].to_i, params[:alert][:'dateEnd(3i)'].to_i)
    rescue ArgumentError
      @dateEnd=nil
    end

    begin
      @dateStart= Date.new(params[:alert][:'dateStart(1i)'].to_i, params[:alert][:'dateStart(2i)'].to_i, params[:alert][:'dateStart(3i)'].to_i)
    rescue ArgumentError
      @dateStart=nil
    end
    @lifecycle_fixed = []
    @lifecycle_consumable = []
    @station = Station.find(params[:station])
    if can_access_station(@station) == false
      return
    end

    @associate_list = []
    @stocks = @station.stocks.where(inTransit: false)
    @stocks.each do |stock|
      @item = stock.item
      @next_dateOfPro = (stock.invoiceDate + @item.lifeCycle.seconds - @item.leadTime.seconds).to_date
      if @item.assetType == 'fixed' && @next_dateOfPro >= @dateStart && @next_dateOfPro <= @dateEnd
        @lifecycle_fixed += [stock]
      elsif @item.assetType = 'consumable'
        @issued_consumables = stock.issued_consumables
        @count = 0
        @issued_consumables.each do |consumable|
          @next_dateOfIssue = (consumable.dateOfIssue + @item.lifeCycle.seconds).to_date
          if  @next_dateOfIssue >= @dateStart && @next_dateOfIssue <= @dateEnd
            @count += consumable.quantity
            @associate_list += [consumable]  
          end
        end
        if @count != 0
          @lifecycle_consumable += [[stock, @count]]
        end
      end
    end
  end

  def transfer_comments
    @transfer = Transfers.find(params[:id])
    @comment = @transfer.comments
    respond_to do |format|
      format.js
    end
  end

  def stock_comments
    @stock = Stock.find(params[:id])
    @comment = @stock.comments
    respond_to do |format|
      format.js
    end
  end


  def transfer_print
    @transfers = Transfers.find(params[:transfers])
    chalanNo = @transfers.first.chalanNo
    station_to = @transfers.first.to
    station_from = @transfers.first.from
    @transfers.each do |transfer|
      if transfer.to != station_to || transfer.from != station_from || chalanNo != transfer.chalanNo
        flash[:error] = "Transfers choosed were not between same stations or different chalan numbers"
        redirect_to '/transfers_list'
        return
      end
    end
    if chalanNo == nil
      chalanNo = ChalanNumber.find(1).chalanNo.to_i + 1
      ChalanNumber.find(1).update_attributes(chalanNo: chalanNo)
      @transfers.each do |transfer|
        transfer.chalanNo = chalanNo
        transfer.save
      end
    end
    send_data(generate_pdf(@transfers, chalanNo), :filename => "output.pdf", :type => "application/pdf") 
  end

end
