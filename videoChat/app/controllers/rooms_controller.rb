class RoomsController < ApplicationController
  before_filter :config_opentok,:except => [:index]

  def index
    @rooms = Room.all
    @new_room = Room.new
  end

  def create
    session = @opentok.create_session
    params[:room][:sessionId] = session.session_id

    @new_room = Room.new(params.require(:room).permit(:name, :sessionId, :public))

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to('/videoChat/party/' + @new_room.id.to_s + '-'+ @new_room.name) }
      else
        format.html { redirect_to root_path, notice: '<font color="red">Party name was blank! Try again.</font>' }
      end
    end
  end

  def party
    @room = Room.find(params[:id])
    @painting = @room.paintings.new
    @apiKey = "45486522"
    @tok_token = @opentok.generate_token @room.sessionId 
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to root_url, notice: '<font color="red">Room was successfully removed</font>'
  end

  def downloadChromeExtension
    @file_name = "chrome_extension.zip"
    @filePath = Rails.root.join('public', @file_name)
    @stat = File::stat(@filePath)
    send_file(@filePath, :filename => @file_name, :length => @stat.size)
  end

  private 
  def config_opentok
    if @opentok.nil?
      require "opentok"
      @opentok = OpenTok::OpenTok.new 45486522, "edcafba1717263b3b076515a8b0623c656dfb12c"
    end
  end
end
