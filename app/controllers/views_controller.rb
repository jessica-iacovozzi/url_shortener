class ViewsController < ApplicationController
  before_action :set_link

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path, alert: "Link does not exist."
  end

  def show
    @link.views.create(user_agent: request.user_agent, ip: request.ip)
    redirect_to @link.url, allow_other_host: true
  end
end
