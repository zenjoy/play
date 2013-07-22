class Api::SystemController < Api::BaseController

  def stream
    redirect_to "#{request.scheme}://#{request.host}:8000"
  end

  def upload
  end

  def volume
    Play.mpd.volume = params[:volume].to_i
    deliver_json(200, {:message => 'ok', :volume => Play.mpd.volume })
  end
end
