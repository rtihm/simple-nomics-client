# frozen_string_literal: true

module SimpleNomics
  module Printer
    module CryptoPriceCompare
      def self.print(data)
        first = data.first
        second = data.last

        diff = second['price'].to_f / first['price'].to_f

        "1 #{second['currency']} is #{diff.round(9)} #{first['currency']}"
      end
    end
  end
end
