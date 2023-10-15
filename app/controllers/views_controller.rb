class ViewsController < ApplicationController
  before_action :set_link

  def show
    @link.views.create(user_agent: request.user_agent, ip: request.ip)
    redirect_to @link.url, allow_other_host: true
  end
end
