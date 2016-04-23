class PaintingsController < ApplicationController

  def index
    @room = Room.find params[:room_id]
    
    respond_to do |format|
      format.js
      format.html
    end
    
  end

  def new
    @room = Room.find params[:room_id]
    @painting = @room.paintings.new()
  end

  def create
    @room = Room.find params[:room_id]
    @painting = @room.paintings.create(params.require(:painting).permit(:name, :room_id, :image))
    if @painting.save
      respond_to do |format|
        format.js
        format.html
      end
    end
    #if @painting.save
      #render :json => @painting.to_json
      #redirect_to party_path(@painting.room)
    #end
  end
 
  def edit
    @painting = Painting.find(params[:id])
  end

  def update
    @painting = Painting.find(params[:id])
    if @painting.update_attributes(params.require(:painting).permit(:name, :room_id, :image))
      redirect_to party_path(@painting.room), notice: '<font color="green">Painting was successfully updated</font>'
    else
      render :edit
    end
  end

  def destroy
    @painting = Painting.find(params[:id])
    @room = @painting.room
    if @painting.destroy
      respond_to do |format|
        format.js
      end
    end
    #redirect_to party_path(@painting.room), notice: '<font color="red">Painting was successfully destroyed</font>'
  end
end
