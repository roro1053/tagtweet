class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      # delete(" ")で文字列から全ての空白を削除する
      # split(",")で受け取った文字列をカンマ（,）区切りで配列にする
      tag_list = tag_params[:words].delete("a").split(",")

      # post.rb に save_tags()メソッドを定義
      @post.save_tags(tag_list)
      redirect_to root_path(@post)
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:name)
    end

    def tag_params
      params.require(:post).permit(:words)
    end
end
