class Api::ControlsController < Api::BaseController

  def play
    Play.mpd.play
    deliver_json(200, {:message => 'ok'})
  end

  def pause
    Play.mpd.pause = true
    deliver_json(200, {:message => 'ok'})
  end

  def next
    Play.mpd.next
    song = PlayQueue.now_playing
    deliver_json(200, song.try(:to_hash))
  end
end
