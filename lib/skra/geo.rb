require "httparty"

require "skra/geo/version"

module Skra
  module Geo
    include HTTParty
    base_uri 'geo.skra.is'
    def self.defaults
      {
        :service => :wfs,
        :version => "1.1.0",
        :request => 'GetFeature',
        :typename => 'fasteignaskra:VSTADF',
        :outputformat => 'json'
      }
    end

    def self.query(filter, options={})
      get_features(filter, options)
    end


    def self.id(id, options={})
      get_features([{:name => :LANDNR, :value => id}], options)
    end

    def self.street(name, number=nil, postcode=nil, options={})
      filter = [
        {:name => :HEITI_NF, :value => name}
      ]
      filter << {:name => :HUSNR,  :value => number}   if number
      filter << {:name => :POSTNR, :value => postcode} if postcode
      get_features(filter, options)
    end

    def self.dative_street(dative_name, number=nil, postcode=nil, options={})
      filter = [
        {:name => :HEITI_TGF, :value => dative_name}
      ]
      filter << {:name => :HUSNR,  :value => number}   if number
      filter << {:name => :POSTNR, :value => postcode} if postcode
      get_features(filter, options)
    end

    protected

    def self.get_features(filter, options)
      query  = defaults.merge(options)
      wfs_filter = build_wfs_filter(filter)
      response = post('/geoserver/wfs', { :query => query.merge(wfs_filter) })
      response["features"]
    end

    def self.build_wfs_filter(properties=[])
      conditions = properties.map do |condition|
        <<-eos
          <PropertyIsLike wildCard="*" singleChar="#" escapeChar="!">
            <PropertyName>fasteignaskra:#{condition[:name]}</PropertyName>
            <Literal>#{condition[:value]}</Literal>
          </PropertyIsLike>
        eos
      end.join
      conditions = "<And>#{conditions}</And>" if properties.size > 1
      properties.size > 0 ? { :filter => "<Filter>#{conditions}</Filter>" } : {}
    end
  end
end
