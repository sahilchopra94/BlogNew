class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:show,:index, :dashboard, :social, :form_element, :form_layout, :form_wizard]
before_action :check_user, :only => [:edit]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @comment=Comment.new

    @comment.article_id = @article.id
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
       if params[:photos]
        params[:photos].each { |photo|
          @article.photos.create(photo: photo)
        }
      end
  flash[:success] = 'Article was successfully created.'
  format.html { redirect_to @article }
  format.json { render :show, status: :created, location: @article }
     else
      flash[:danger] = 'There was a problem creating the Article.'
      format.html { render :new }
      format.json { render json: @article.errors, status: :unprocessable_entity }
    end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
  respond_to do |format|
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated.'
      format.html { redirect_to @article }
      format.json { render :show, status: :ok, location: @article }
    else
      flash[:danger] = 'There was a problem updating the Article.'
      format.html { render :edit }
      format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end
end

def dashboard
end

def social
end

def form_element
end


def form_layout
end

def form_wizard
end
  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
  flash[:success] = 'Article was successfully destroyed.'
  format.html { redirect_to articles_url }  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title,:body,:photo, :photos, :user)
    end
    def check_user
    @article = Article.find(params[:id])
    if current_user.id != @article.user_id
       redirect_to article_path(@article)
       flash[:danger] = 'Unauthorized access!!'
    end
 end
end