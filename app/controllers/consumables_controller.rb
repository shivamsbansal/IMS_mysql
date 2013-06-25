class ConsumablesController < ApplicationController
	before_filter :signed_in_user
	before_filter :atleast_one_station

  def consumable_issue
  	@stock = Stock.find(params[:id])
  	@station = @stock.station
    @associates = @station.associates
    @item = @stock.item
  end

  def issueConsumable
  	begin
      @date= Date.new(params[:issued_consumable][:'dateOfIssue(1i)'].to_i, params[:issued_consumable][:'dateOfIssue(2i)'].to_i, params[:issued_consumable][:'dateOfIssue(3i)'].to_i)
    rescue ArgumentError
      @date=nil
    end
    @issued = IssuedConsumable.new(stock_id: params[:stock_id], associate_id: params[:associate_id], dateOfIssue: @date)

    @stock = Stock.find(params[:stock_id])
    @stock.presentStock = @stock.presentStock - 1

    if ([@stock,@issued].map(&:valid?)).all?
      @stock.save
      @issued.save
      flash[:success] = "Successfully issued"
    else
      flash[:error] = "Unsuccessfull issue check date"
    end
    redirect_to "/consumable_issue/#{@stock.id}"
  end

  def withdraw
    @consumable = IssuedConsumable.find(params[:id])
    @stock = @consumable.stock
    @associate = @consumable.associate
    @stock.presentStock = @stock.presentStock + 1
    @stock.save
    @consumable.destroy
    flash[:success] = "Consumable withdrawn."
    redirect_to "/assets/issued_list/#{@associate.id}"
  end

end
