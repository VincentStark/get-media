module ApplicationHelper

  def process_param(param, session_param = param, default = nil)
    session[session_param] = params[param] unless params[param].nil?
    sort = ( session[session_param].nil? ? default : session[session_param] )
  end

  def time_in_words(t)
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "%d d %d h %d min %d sec" % [dd, hh, mm, ss]
  end
end
