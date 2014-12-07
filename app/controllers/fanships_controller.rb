class FanshipsController < ApplicationController
	def create
    @band = Band.find(params[:band_id])
    current_user.become_fan(@band)
    respond_to do |format|
      format.html { redirect_to @band }
      format.js
    end
  end

  def destroy
    @band = Fanships.find(params[:id]).band
    current_user.undo_become_fan(@band)
    respond_to do |format|
      format.html { redirect_to @band }
      format.js
    end
  end
end
