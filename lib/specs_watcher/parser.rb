require 'nokogiri'
require 'pry'

module SpecsWatcher
  class Parser
    def self.parse(raw_html)
      new(raw_html).parse
    end

    attr_reader :raw_html
    def initialize(raw_html)
      @raw_html = raw_html
    end

    def parse
      doc = Nokogiri::HTML(raw_html)
      rows = doc.css('tr[valign="TOP"]')
      rows.map { |r| parse_row(r) }
    end

    def parse_row(r)
      td = r.css("td")
      {
        title: td[1].children[0].text.strip,
        price: td[4].children[0].text.strip.to_f,
        size: td[2].text.strip,
        case_price: td[4].children[2].text.strip.to_f,
        case_size: td[3].children[2].text.strip,
        description: td[1].children[3].text.strip,
        image: image_base_uri + r.css("img").first["src"],
        upc: td.css('a').last['onclick'][/showavail\('(.*)'\)/, 1]
      }
    end

    def image_base_uri
      "http://www.specsonline.com"
    end
  end
end
