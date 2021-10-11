# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

module SimpleNomics
  module Fetcher
    class RequestError < StandardError; end

    API_BASE = 'https://api.nomics.com/v1'
    API_TICKER_PATH = '/currencies/ticker'

    def fetch_json(url, params = {})
      uri = URI(url)
      uri.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 10
      http.use_ssl = uri.scheme == 'https'
      response = http.start { |req| req.get(uri.request_uri) }

      raise RequestError, "Request failed: `#{response.code} #{response.body}`" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end

    # def query_params(params)
    #   query = []
    #   params.each do |key, value|
    #     query << "#{key}=#{URI.escape(value)}" if value
    #   end

    #   query.join('&')
    # end

    def currency_ticker(currency: 'BTC', convert: 'USD')
      currencies = Array(currency)

      fetch_json(API_BASE + API_TICKER_PATH, ids: currencies.join(','), convert: convert)
    end

    module_function :fetch_json, :currency_ticker
  end
end
