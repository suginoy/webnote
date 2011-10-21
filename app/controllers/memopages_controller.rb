#encoding: utf-8
class MemopagesController < ApplicationController
  before_filter :check_auth

  # GET /memopages
  # GET /memopages.json
  def index
    @memopages = Memopage.scoped.order('created_at DESC').page params[:page]

    @search_form = SearchForm.new(params[:search_form])
    if @search_form.q.present?
      @memopages = @memopages.title_or_content_matches @search_form.q
    end 

    @memopages = case params[:public]
                 when 'open'
                   @memopages.open session[:login_user]
                 when 'self'
                   @memopages.self session[:login_user]
                 else #'all'
                   @memopages.both session[:login_user]
                 end
    session[:public] = params[:public]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memopages }
    end
  end

  # GET /memopages/1
  # GET /memopages/1.json
  def show
    @memopage = Memopage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @memopage }
    end
  end

  # GET /memopages/new
  # GET /memopages/new.json
  def new
    @memopage = Memopage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @memopage }
    end
  end

  # GET /memopages/1/edit
  def edit
    @memopage = Memopage.find(params[:id])
  end

  # POST /memopages
  # POST /memopages.json
  def create
   #@memopage = Memopage.new(params[:memopage])
    @memopage = session[:login_user].memopages.build(params[:memopage])

    respond_to do |format|
      if @memopage.save
        format.html { redirect_to @memopage, notice: 'Memopage was successfully created.' }
        format.json { render json: @memopage, status: :created, location: @memopage }
      else
        format.html { render action: "new" }
        format.json { render json: @memopage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /memopages/1
  # PUT /memopages/1.json
  def update
    @memopage = Memopage.find(params[:id])

    respond_to do |format|
      if @memopage.update_attributes(params[:memopage])
        format.html { redirect_to @memopage, notice: 'Memopage was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @memopage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memopages/1
  # DELETE /memopages/1.json
  def destroy
    @memopage = Memopage.find(params[:id])
    @memopage.destroy

    respond_to do |format|
      format.html { redirect_to memopages_url }
      format.json { head :ok }
    end
  end

  # Ajax
  def add_comment
    @comment = Comment.new(params[:comment])
    
    @comment.save unless @comment.message.empty?
    @memopage = @comment.memopage

    render :template => "memopages/comment"

   # respond_to do |format|
   #  #format.html # show.html.erb
   #  #format.json { render json: @memopage }

   #   format.js { render :template => "comment" }
   # end
  end

  private

  def check_auth
    unless session[:login_user]
      flash[:notice] = 'ログインする必要があります'
      redirect_to :controller => 'welcome', :action => 'index'
    end
  end
end
