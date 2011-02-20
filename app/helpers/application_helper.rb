module ApplicationHelper
  def sanitize_partial(html)
    html.gsub("\"", "'").gsub("\n", "").strip if html
  end
end
