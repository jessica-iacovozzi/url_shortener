require "open-uri"

class Metadata
  attr_reader :doc

  def self.retrieve_from(url)
    new(URI.parse(url).open)
  rescue
    new
  end

  def initialize(html = nil)
    @doc = Nokogiri::HTML(html)
  end

  def attributes
    {
      title: title,
      description: description,
      image: image
    }
  end

  def title
    doc.at_css("title")&.text
  end

  def description
    meta_tag_content("og:description")
  end

  def image
    meta_tag_content("og:image")
  end

  def meta_tag_content(name)
    doc.at_css("meta[property='#{name}']")&.attributes&.fetch("content", nil)&.text
  end
end
