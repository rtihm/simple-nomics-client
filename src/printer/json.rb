require 'json'

module SimpleNomics
  module Printer
    module JSON
      def self.print(data, filters: [])
        data = data.select { |key, _| filters.include?(key) } unless filters.empty?

        ::JSON.pretty_generate(data) + "\n"
      end
    end
  end
end
