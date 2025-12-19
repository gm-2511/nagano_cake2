class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer! 

  def index
    # ログイン中の顧客のカートアイテム全てを取得
    @cart_items = current_customer.cart_items.all
  end

  def create
    # フォームから送られたデータ（item_id と amount）を取得
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    # 1. すでにカートに同じ商品があるかチェック
    @existing_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)

    if @existing_cart_item.present?
      # 2. 既に存在する場合: 数量を合算して更新
      new_amount = @existing_cart_item.amount + @cart_item.amount
      @existing_cart_item.update(amount: new_amount)
      redirect_to cart_items_path, notice: "数量を変更しました。"
    else
      # 3. 存在しない場合: 新規作成
      if @cart_item.save
        redirect_to cart_items_path, notice: "カートに商品を追加しました。"
      else
        # エラー処理（例: 数量が0だった場合など）
        flash[:alert] = "カートに商品を追加できませんでした。"
        # どのページに戻るか設計次第ですが、ここでは商品一覧に戻ります
        redirect_to items_path
      end
    end
  end

  def update
    # 変更したいカートアイテム（:id）を特定
    @cart_item = current_customer.cart_items.find(params[:id])
    
    # フォームから送られた新しい数量で更新
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "数量を変更しました。"
    else
      # バリデーションエラー（例: 数量を0以下にした場合など）が発生した場合
      # カート一覧ページに戻り、エラーメッセージを表示するために再度 @cart_items を取得
      @cart_items = current_customer.cart_items.all
      flash.now[:alert] = "数量の変更に失敗しました。（数量は1以上である必要があります。）"
      render :index, status: :unprocessable_entity # 422 Unprocessable Entity
    end
  end

  def destroy
    # 削除したいカートアイテム（:id）を特定
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "カートから商品を削除しました。"
  end

  def destroy_all
    # ログイン中の顧客のカートアイテムを全て削除
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました。"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
