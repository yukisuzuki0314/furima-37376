class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index

  before_action :set_order

  def index
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
    @order_pay_form = OrderPayForm.new
  end

  def create
    @order_pay_form = OrderPayForm.new(order_params)
    if @order_pay_form.valid?
      pay_item
      @order_pay_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_pay_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # テスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token], # トークン
      currency: 'jpy'                 # 通貨の種類
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end
end
