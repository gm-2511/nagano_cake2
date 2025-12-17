class Public::ItemsController < ApplicationController
  # 商品一覧
  def index
    # 販売中の商品のみを対象とするクエリをスタート地点とする
    base_items = Item.where(is_active: true).order(created_at: :desc)
    # 全ジャンルを取得し、サイドバーに渡す
    @genres = Genre.all
    # 絞り込みロジックの追加
    if params[:genre_id].present?
      # ジャンルIDがある場合、基本クエリにジャンル条件を追加
      @items = base_items.where(genre_id: params[:genre_id]).page(params[:page]).per(8)
      @genre_name = Genre.find(params[:genre_id]).name # 絞り込み表示用にジャンル名も取得
    else
      # ジャンルIDがない場合、基本クエリ（販売中のみ）をそのまま使用
      # ページネーション（1ページあたり8件表示）を適用
      @items = base_items.page(params[:page]).per(8)
      @genre_name = "全ての商品" # 全件表示であることを示す
    end
  end
  
  # 商品詳細
  def show
    # 特定の商品をIDで取得する
    # find_by を使っているので、見つからない場合は nil になる
    @item = Item.find_by(id: params[:id], is_active: true)
    
    # カート投入用の空のインスタンス
    @cart_item = CartItem.new
    
    # showアクションでも全ジャンルを取得
    @genres = Genre.all
    
    # 商品が見つからなかった場合（URLを直接操作された場合など）の処理
    unless @item
      redirect_to items_path, alert: "指定された商品は存在しないか、現在販売を停止しています。"
    end
  end
end
