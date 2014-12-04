class ConcertListsController < ApplicationController
  before_action :set_concert_list, only: [:show, :edit, :update, :destroy]

  # GET /concert_lists
  # GET /concert_lists.json
  def index
    @concert_lists = ConcertList.all
  end

  # GET /concert_lists/1
  # GET /concert_lists/1.json
  def show
  end

  # GET /concert_lists/new
  def new
    @concert_list = ConcertList.new
  end

  # GET /concert_lists/1/edit
  def edit
  end

  # POST /concert_lists
  # POST /concert_lists.json
  def create
    @concert_list = ConcertList.new(concert_list_params)

    respond_to do |format|
      if @concert_list.save
        format.html { redirect_to @concert_list, notice: 'Concert list was successfully created.' }
        format.json { render :show, status: :created, location: @concert_list }
      else
        format.html { render :new }
        format.json { render json: @concert_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concert_lists/1
  # PATCH/PUT /concert_lists/1.json
  def update
    respond_to do |format|
      if @concert_list.update(concert_list_params)
        format.html { redirect_to @concert_list, notice: 'Concert list was successfully updated.' }
        format.json { render :show, status: :ok, location: @concert_list }
      else
        format.html { render :edit }
        format.json { render json: @concert_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concert_lists/1
  # DELETE /concert_lists/1.json
  def destroy
    @concert_list.destroy
    respond_to do |format|
      format.html { redirect_to concert_lists_url, notice: 'Concert list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert_list
      @concert_list = ConcertList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_list_params
      params.require(:concert_list).permit(:list_owner_id, :title, :description)
    end
end
