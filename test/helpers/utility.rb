module Play
  module UtilityHelpers
    def app
      Play::App
    end

    def parse_json(json)
      Yajl.load(json, :symbolize_keys => true)
    end
  end
end