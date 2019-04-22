class CollectorsController < ApplicationController
  before_filter :signed_in_user, only: [ :index ]
  before_filter :admin_user, only: [ :index ]

  def index
    # Toggle sorting
    if session[:sort_collector] == params[:sort] && !params[:sort].nil?
      sort = session[:sort_collector] + ' DESC'
      session[:sort_collector] = sort
    else
      sort = process_param(:sort, :sort_collector, 'checked_at')
    end
    page = process_param(:page, :page_collector)

    # Special sorting cases
    if sort.include?('downloads_total')
      collectors_scope = ActiveRecord::Base::Collector.downloads_count
    elsif sort.include?('downloads_bitrate')
      collectors_scope = ActiveRecord::Base::Collector.bitrate_count
    elsif sort.include?('ip')
      sort = sort.gsub('ip', 'INET(ip)')
      collectors_scope = ActiveRecord::Base::Collector
    else
      collectors_scope = ActiveRecord::Base::Collector
    end

    # ", id ASC" is used to maintain sorting order
    @collectors = collectors_scope.order(sort + ', collectors.id ASC').paginate(:page => page)
  end

  #def show
  #  @collector = ActiveRecord::Base::Collector.find(params[:id])
  #end

  def update
    @collector = ActiveRecord::Base::Collector.find(params[:id])
    @collector.attributes = params[:collector]
    if !@collector.save(:validate => false)
      @ajax_error = @collector.error.full_message
    end
    respond_to do |format|
      format.html { redirect_to collectors_path }
      format.js { render 'shared/ajax-progress' }
    end
  end
end
