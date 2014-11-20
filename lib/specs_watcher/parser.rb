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
      {
        image: image_base_uri + r.css("img").first["src"],
        title: r.css("td")[1].text.strip,
        size: r.css("td")[2].text.strip,
        price: r.css("td")[4].children[0].text.strip.to_f,
        case_price: r.css("td")[4].children[2].text.strip.to_f,
        case_size: r.css("td")[3].children[2].text.strip
      }
    end

    def image_base_uri
      "http://www.specsonline.com"
    end
  end
end
