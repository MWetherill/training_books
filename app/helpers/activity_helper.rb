
module ActivityHelper
  def render_activity_with_fallback(activity, options = {}, &block)
    render_activity activity, options

  rescue ActionView::MissingTemplate
    capture &block
  end

  def past_tense(string)
    string +=
      case string.last
      when "e"
        "d"
      when "E"
        "D"
      when "a".."z"
        "ed"
      when "A".."Z"
        "ED"
      end
  end

  def link_to_trackable(activity, html_options = nil, &block)
    capitalize = html_options&.delete(:capitalize)

    if !block_given?
      block = proc do
        "#{capitalize ? 'A' : 'a'} #{activity.trackable_type.underscore.humanize.downcase}"
      end
    end

    begin
        url_for activity.trackable
    rescue NoMethodError
      return capture &block
    end

    if activity.trackable.present? && !activity.trackable.deleted?
      link_to activity.trackable, html_options, &block
    else
      capture &block
    end
  end
end
