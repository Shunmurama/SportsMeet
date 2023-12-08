class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリーを追加しました。"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "入力してください。"
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリーを編集しました。"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "入力してください。"
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    flash[:notice] = "カテゴリーを削除しました。"
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
