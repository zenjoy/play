class Api::QueueController < Api::BaseController

  def now_playing
    song = PlayQueue.now_playing
    deliver_json(200, song.try(:to_hash))
  end

  def search
    songs = Song.find([:any, params[:search]]) unless params[:search].blank?
    if songs.present?
      deliver_json(200, songs.collect(&:to_hash))
    else
      deliver_json(404, {:message => "No songs found"}) 
    end
  end

  def search_and_add
    songs = Song.find([:any, params[:search]]) unless params[:search].blank?
    if songs.present?
      Play.mpd.clear if params[:clear].to_i == 1
      songs = songs.shuffle[0..9]
      songs.each{|s| PlayQueue.add(s, current_user)}
      Play.mpd.play if !Play.mpd.playing?
      deliver_json(200, songs.collect(&:to_hash))
    else
      deliver_json(404, {:message => "No songs found"}) 
    end
  end

  def list
    deliver_json(200, {:songs => PlayQueue.songs.collect(&:to_hash)})
  end

  def add
    case params[:type]
    when /song/
      artist = Artist.new(:name => params[:artist_name])
      song = artist.songs.find{|s| s.title == params[:song_name]}
      PlayQueue.add(song,current_user)
    when /album/
      artist = Artist.new(:name => params[:artist_name])
      album  = Album.new(:artist => artist, :name => params[:album_name])
      album.songs.each{|s| PlayQueue.add(s, current_user)}
    end

    deliver_json(200, {:songs => PlayQueue.songs.collect(&:to_hash)})
  end

  def remove
    artist = Artist.new(:name => params[:artist_name])
    song = artist.songs.find{|s| s.title == params[:song_name]}
    PlayQueue.remove(song,current_user)

    deliver_json(200, {:songs => PlayQueue.songs.collect(&:to_hash)})
  end

  def clear
    Play.mpd.clear
    song = Song.new(:path => Play.mpd.files[:file].sample)
    PlayQueue.add(song, nil)
    Play.mpd.play
    deliver_json(200, {:songs => PlayQueue.songs.collect(&:to_hash)})
  end


end
