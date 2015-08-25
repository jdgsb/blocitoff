class ItemsController < ApplicationController
  respond_to :html, :js

  def create
    @user = User.find(params[:user_id])
    @item = current_user.items.create(item_params)

    if @item.save
      redirect_to :user_root
    else
      render :back
    end
  end

  def destroy
     @user = User.find(params[:user_id])
     @item = Item.find(params[:id])
     @item.destroy


    respond_to do |format|
         format.html
         format.js
    end
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end
end
