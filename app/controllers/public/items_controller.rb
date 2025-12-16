class Public::ItemsController < ApplicationController
  # 商品一覧
  def index
    # ページネーション（1ページあたり8件表示）と販売中の商品のみを対象とする
    @items = Item.where(is_active: true).page(params[:page]).per(8)
  end
  
  # 商品詳細
  def show
    # 特定の商品をIDで取得する
    # ただし、販売中の商品（is_active: true）のみを対象とする
    @item = Item.find_by(id: params[:id], is_active: true)
    
    # 商品が見つからなかった場合（URLを直接操作された場合など）の処理
    unless @item
      redirect_to items_path, alert: "指定された商品は存在しないか、現在販売を停止しています。"
    end
  end
end
