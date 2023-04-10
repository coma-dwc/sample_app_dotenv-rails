class ListsController < ApplicationController
  def new
    #Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new
  end

#以下を追加
  def create
    @list = List.new(list_params)
    if @list.save
      #フラッシュメッセージ実装の為下記び1行を追加
      flash[:notice] = "投稿が成功しました"
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end


  def index
    @lists = List.all #複数のListレコードが取得できるので複数形のlistsにした
  end

  def show
    @list = List.find(params[:id]) #レコードを1件だけ取得するので単数形のlistにした
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id]) #データ(レコード)を1件取得
    list.destroy #データ(レコード)を削除
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end



  private
  #ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
