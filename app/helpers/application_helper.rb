module ApplicationHelper
  include Pagy::Frontend
  def build_breadcrumb(category)
    result = []
    category.ancestors.each do |ancestor|
      result << content_tag(:li, class: 'breadcrumb-item') do
        link_to(ancestor.name, ancestor)
      end
    end
    result << content_tag(:li, category.name, class: 'breadcrumb-item active')
    result.join('').html_safe
  end

  def app_info(current_user)
    info = InfoService.new
    info.app_info(current_user)
  end
end
