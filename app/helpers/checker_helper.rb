module CheckerHelper
  def percentage_td percentage
    case percentage
    when 0
      tdclass = 'success'
    when 0..1
      tdclass = 'warning'
    else
      tdclass = 'danger'
    end
    content_tag :td, number_to_percentage(percentage), class: tdclass
  end
end
