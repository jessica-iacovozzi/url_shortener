class MetadataJob < ApplicationJob
  def perform(id)
    link = Link.find_by_short_code(id)
    link.update(Metadata.retrieve_from(link.url).attributes)
    link.broadcast_replace_to(link)
  end
end
