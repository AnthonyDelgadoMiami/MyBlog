module ApplicationHelper
  def toggle_direction(column)
    if @sort_column == column && @sort_direction == 'asc'
      'desc'
    else
      'asc'
    end
  end

  def sort_link_class(column, sort_column, sort_direction)
    if column == sort_column
      sort_direction == 'asc' ? 'sorted-asc' : 'sorted-desc'
    else
      'sortable'
    end
  end
end
