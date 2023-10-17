class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]
  before_action :check_if_editable, only: %i[edit update destroy]

  def index
    @pagy, @links = pagy Link.recent_first
    @link ||= Link.new
  rescue Pagy::OverflowError
    redirect_to root_path
  end

  def my_links
    @pagy, @links = pagy Link.where(user_id: current_user)
  rescue Pagy::OverflowError
    redirect_to my_links_path
  end

  def show
  end

  def create
    @link = Link.new(link_params.with_defaults(user: current_user))
    if @link.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("links", @link) }
      end
    else
      index
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to @link, notice: "Successfully updated link!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path, notice: "Link has been deleted."
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def check_if_editable
    return if @link.editable_by?(current_user)

    redirect_to @link, alert: "You aren't allowed to edit this link."
  end
end
