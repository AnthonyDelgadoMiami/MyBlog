require 'digest'

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

  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle")
  end
end