require 'json'

module SimpleNomics
  module Printer
    module JSON
      def self.print(data, filters: [])
        unless filters.empty?
          data = data.map do |ticker|
            ticker.select { |key, _| filters.include?(key) }
          end
        end

        ::JSON.pretty_generate(data) + "\n"
      end
    end
  end
end
