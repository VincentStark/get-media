class DownloadsController < ApplicationController
  before_filter :signed_in_user, only: [ :index, :create, :update ]

  def index
    @downloads = current_user.downloads.paginate(:page => params[:page])
  end

  def create

    if params[:download][:url].empty?
      @ajax_error = 'You should specify URL'
    elsif params[:download][:quality].empty?
      @ajax_error = 'You should specify the desired quality'
    end

    # Get IP address of the remote collector
    ip = ActiveRecord::Base::Collector.bitrate_count.order('downloads_bitrate ASC').first.ip

    # Send an insertion request
    # ...

    respond_to do |format|
      format.html { redirect_to downloads_path }
      format.js { render 'shared/ajax-progress' }
    end
  end

  def update
    # Get IP address of the remote collector
    ip = Download.find(params[:id]).collector.ip

    # Delete content or cancel download
    # ...

    respond_to do |format|
      format.html { redirect_to downloads_path }
      format.js { render 'shared/ajax-progress' }
    end
  end

  def remote
    @response = Api::Download.find(575).name
    #@response = Api::Download.get(:time)
  end
end

module Api
  class Download < ActiveResource::Base
    self.site = "http://localhost:3001"
  end
end
