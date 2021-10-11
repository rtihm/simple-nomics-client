module SimpleNomics
  module Printer
    module PriceOnly
      def self.print(data, currency)
        data.map do |ticker|
          name = ticker['name']
          price = ticker['price'].to_f.round(3)

          "#{name} #{price} #{currency}"
        end.join("\n")
      end
    end
  end
end
