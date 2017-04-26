class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
before_action :set_article
before_action :authenticate_user!, except: [:show]
before_filter :check_user, :only => [:edit]

  def show
    byebug
    redirect_to @article
  end


  def edit

  end


  def create
    @comment = Comment.new(comment_params)
     @comment.user_id = current_user.id
    @comment.article_id = @article.id
    @comment.save
         redirect_to article_path(@comment.article)
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @article, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_article
      @article = Article.find(params[:article_id])
end



    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:author_name,:body,:article_id,:rating,:user_id, :photo)
end
def check_user
    @comment =Comment.find(params[:id])
    unless current_user.id == @comment.user_id
       redirect_to (request.referrer || root_path)
       return
    end
 end
end