class Api::SystemController < Api::BaseController

  def stream
    redirect_to "#{request.scheme}://#{request.host}:8000"
  end

  def stream_url
    deliver_json(200, {:stream_url => Play.config["stream_url"]})
  end

  def upload
  end

  def set_volume
    Play.mpd.volume = params[:volume].to_i
    deliver_json(200, {:message => 'ok', :volume => Play.mpd.volume })
  end

  def volume
    deliver_json(200, {:volume => Play.mpd.volume })
  end
end
