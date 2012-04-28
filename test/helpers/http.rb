module Play
  module HTTPHelpers
    def authorized_rack_header
      user = User.create('maddox', 'maddox@github.com')
      {"HTTP_AUTHORIZATION" => user.token}
    end

    def authorized_get(uri, opts={})
      get uri, opts, authorized_rack_header
    end

    def authorized_post(uri, opts={})
      post uri, opts, authorized_rack_header
    end

    def authorized_put(uri, opts={})
      put uri, opts, authorized_rack_header
    end

    def authorized_delete(uri, opts={})
      delete uri, opts, authorized_rack_header
    end

    def unauthorized_get(uri, opts={})
      rack_env = {"HTTP_AUTHORIZATION" => "xxxxxxxxxxxxxxxxxx"}
      get uri, opts, rack_env
    end
  end
end