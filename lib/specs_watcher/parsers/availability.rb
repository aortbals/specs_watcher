require 'nokogiri'

module SpecsWatcher
  module Parsers
    class Availability
      def self.parse(raw_html)
        new(raw_html).parse
      end

      attr_reader :raw_html
      def initialize(raw_html)
        @raw_html = raw_html
      end

      def parse
        doc = Nokogiri::HTML(raw_html)
        rows = doc.css('table')[1].css('tr')
        {
          title: doc.css('center').css('font')[0].children[2].text.strip,
          locations: rows.map { |r| parse_rows(r) }
        }
      end

      def parse_rows(tr)
        {
          store_name: tr.children[0].text,
          availability: tr.children[1].text
        }
      end
    end
  end
end
