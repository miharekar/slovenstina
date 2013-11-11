class CheckerController < ApplicationController
  def new
  end

  def create
    @checker = Checker.new(params[:checker][:text])
  end
end
