class Admin::PrefecturesController < ApplicationController
  def index
    @prefecture = Prefecture.new
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
  end

  private
    def prefecture_params
      params.require(:prefecture).permit(:name)
    end
end
