class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all.where(wiki_id: params[:wiki_id])
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
  end

  # GET /pages/new
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new
    authorize @page
  end

  # GET /pages/1/edit
  def edit
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])
    
  end

  # POST /pages
  # POST /pages.json
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.new(page_params)
    @page.wiki = @wiki
    authorize @page

    
    

    respond_to do |format|
      if @page.save
        format.html { redirect_to [@wiki, @page], notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @wiki = Wiki.find(params[:wiki_id])
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to [@wiki, @page], notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :body)
    end
end
