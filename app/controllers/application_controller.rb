class ApplicationController < ActionController::Base
  include Pagy::Backend

  def set_link
    @link = Link.find_by_short_code(params[:id])
  end

  def default_url_options
    if Rails.env.production?
      { host: "shorturl.ltd" }
    else
      { host: "localhost", port: "3000" }
    end
  end
end
