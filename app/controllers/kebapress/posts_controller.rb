require_dependency "kebapress/application_controller"

module Kebapress
  class PostsController < ApplicationController
    def index
    	@posts = Kebapress::Post.published.order("published_at DESC")
    end

    def new
      @post = Kebapress::Post.new
      render layout: 'layouts/hq/application'
    end

    def create
      @post = Kebapress::Post.new(post_params)
      @post.published = false unless @post.published
      @post.published_at = Time.now if @post.published

      if @post.save
        redirect_to '/blog/dashboard'
      else
        render 'new', layout: 'layouts/hq/application'
      end
    end

    def show
      @post = Kebapress::Post.find(params[:id])
      render layout: 'kebapress/application'
    end

    def edit
      @post = Kebapress::Post.find(params[:id])
      render layout: 'layouts/hq/application'
    end

    def update
      @post = Kebapress::Post.find(params[:id])
      @post.published = false unless params[:published]
      @post.published_at ||= Time.now if @post.published
      @post.update(post_params)

      redirect_to '/blog/dashboard'
    end

    def destroy
      @post = Kebapress::Post.find(params[:id])
      @post.destroy

      redirect_to '/blog/dashboard'
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :published)
      end
  end
end
