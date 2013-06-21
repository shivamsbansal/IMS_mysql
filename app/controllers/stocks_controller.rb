class StocksController < ApplicationController
  before_filter :signed_in_user
  
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
    @stock = Stock.new(station_id: params[:station_id], item_id: params[:item_id], poId: params[:poId], poDate: @poDate, invoiceNo: params[:invoiceNo], invoiceDate: @invoiceDate, warrantyPeriod: @warrantyPeriod, initialStock: params[:initialStock], presentStock: params[:presentStock], issuedReason: params[:issuedReason]  )
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
    @stock = Stock.find(params[:id])
    #@category = @item.itemCategory_type
  end
end
