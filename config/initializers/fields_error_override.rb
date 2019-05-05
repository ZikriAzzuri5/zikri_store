ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = html_tag
  inputs = Nokogiri::HTML::DocumentFragment.parse(html_tag).css('input, select, textarea')

  inputs.each do |input|
    if instance.error_message.kind_of?(Array)
      error_message = instance.error_message.uniq.join(', ')
    else
      error_message = instance.error_message
    end

    error_feedback = "<div class='invalid-feedback'>#{error_message}</div>"

    input.set_attribute('class', "#{input['class']} is-invalid")
    html = "#{input}#{error_feedback}".html_safe
  end

  html
end