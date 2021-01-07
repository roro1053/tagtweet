class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @apost = Post.new(post_params)
    if @apost.save
      # delete(" ")で文字列から全ての空白を削除する
      # split(",")で受け取った文字列をカンマ（,）区切りで配列にする
      tag_list = tag_params[:words].delete(" ").split(",")

      # Article.rb に save_tags()メソッドを定義
      @post.save_tags(tag_list)
      redirect_to @post
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:name)
    end

    # タグ用にストロングパラメータを設定して、文字列を受け取る
    def tag_params
      params.require(:post).permit(:words)
    end
end
