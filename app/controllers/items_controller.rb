class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found_response

  def index
    items = Item.all

    if params[:user_id]
      user = User.find(params[:user_id])
      render json: items, include: :user
    else
      render json: items, include: :user
    end
  end

  def show
    item = Item.find(params[:id])
    render json: item, status: :ok
  end

  def create
    user = User.find(params[:user_id])
    new_item = user.items.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
    )
    render json: new_item, status: :created
  end

  private

  def resource_not_found_response
    render json: { error: "Not Found" }, status: :not_found
  end
end
