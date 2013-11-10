class CheckerController < ApplicationController
  def new
  end

  def create
    @checker = Checker.new(params[:checkin][:text])
  end
end
