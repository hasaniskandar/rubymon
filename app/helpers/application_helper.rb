module ApplicationHelper
  def sortable_th_tag(text, sort_col, options = {})
    icon = content_tag :i, nil, class: "fa fa-sort#{"-#{@sort_dir}" if @sort_col == sort_col && @sort_dir.in?(%w[asc desc])}"
    url = url_for params.merge(sort_col: sort_col, sort_dir: @sort_col == sort_col && @sort_dir == "asc" ? "desc" : "asc")
    content_tag :th, options.merge(class: [:clearfix, options[:class]]) do
      link_to raw(text + icon), url, class: "list-sorter"
    end
  end
end
