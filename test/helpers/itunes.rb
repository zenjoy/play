module Play
  module ItunesHelpers
    # Setup the test-specific playlist we have for Play.
    #
    # - If it doesn't exist, create a normal iTunes Playlist called "play/test".
    # - If it does exist, wipe that playlist out.
    # - Setup two songs and set them as ivars:
    #
    #     @listed   = The only song added to the playlist.
    #     @unlisted = A song that hasn't been added to the playlist.
    def itunes_setup
      name = 'play-test'

      # Try to find our test playlist by looping through all playlist names
      found = Play::Player.app.playlists.get.select{|playlist| playlist.get.name.get == name}

      # If we can't find it, make it
      if found.empty?
        Play::Player.app.make(:new => :user_playlist, :with_properties => {:name => name})
      end

      # Set up our main Playlist object
      @playlist = Play::Player.app.playlists[name]

      # Clear this playlist of all old debris
      @playlist.tracks.get.each { |record| record.delete }

      # Add our listed
      @listed ||= Play::Song.initialize_from_record(Play::Player.app.tracks[1])
      Player.app.add(@listed.record.location.get, :to => @playlist.get)

      # And find an unlisted
      @unlisted ||= Play::Song.initialize_from_record(Play::Player.app.tracks[2])
    end
  end
end