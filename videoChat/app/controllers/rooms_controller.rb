class RoomsController < ApplicationController
  before_filter :config_opentok,:except => [:index]

  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    session = @opentok.create_session
    params[:room][:sessionId] = session.session_id

    @new_room = Room.new(params.require(:room).permit(:name, :sessionId, :public))

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to('/videoChat/party/' + @new_room.id.to_s + '-'+ @new_room.name)}
      else
        format.html { render :controller => ‘rooms’, :action => “index” }
      end
    end
  end

  def party
    @room = Room.find(params[:id])
    @apiKey = "45486522"
    @tok_token = @opentok.generate_token @room.sessionId 
  end

  private 
  def config_opentok
    if @opentok.nil?
      require "opentok"
      @opentok = OpenTok::OpenTok.new 45486522, "edcafba1717263b3b076515a8b0623c656dfb12c"
    end
  end
end
