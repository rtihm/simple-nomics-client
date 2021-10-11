# frozen_string_literal: true

require_relative '../src/fetcher'

RSpec.describe SimpleNomics::Fetcher do
  describe ".fetch_json" do
    let(:url) { 'http://example.com/resource' }

    context "successful request" do
      let(:response) do
        { 'data' => 'Foo' }
      end
      let(:json_response) { JSON.generate(response) }

      it "returns parsed JSON as object" do
        stub_request(:get, url).to_return(status: 200, body: json_response)

        request_response = described_class.fetch_json(url)

        expect(request_response).to eq(response)
      end
    end

    context "unsuccessful request" do
      it "raises error" do
        stub_request(:get, url).to_return(status: 404, body: 'Not found')

        expect do
          described_class.fetch_json(url)
        end.to raise_error(described_class::RequestError, 'Request failed: `404 Not found`')
      end
    end

    context "query params" do
      let(:query_params) { { foo: :bar, baz: 'escape me' } }
      let(:query_params_string) { 'foo=bar&baz=escape%20me' }
      let(:url_with_query) { "#{url}?#{query_params_string}" }

      it "send with the request" do
        stub_request(:get, url_with_query)
          .to_return(status: 200, body: '{}')

        described_class.fetch_json(url_with_query, query_params)

        expect(WebMock).to have_requested(:get, url_with_query)
      end
    end
  end

  describe ".currency_ticker" do
    let(:url) { 'https://api.nomics.com/v1/currencies/ticker' }
    let(:currencies) { %w(ETH BTC) }
    let(:fiat) { 'EUR' }
    let(:key) { 'API-KEY' }

    it "returns parsed response as object" do
      expect(described_class).to receive(:fetch_json)
        .with(url, ids: currencies.join(','), convert: fiat, key: key)
        .and_return(nil)

      result = described_class.currency_ticker(currency: currencies, convert: fiat, api_key: key)

      expect(result).to eq(nil)
    end
  end
end
