module ApplicationHelper

  def to_rupiah(price)
    number_to_currency(price, unit: 'Rp ', precision: 0, delimiter: '.')
  end

  def flash_class(level)
    base_class = 'sticky-top alert js-flash-alert fade out show '
    type_class = case level
      when 'notice' then "alert-info"
      when 'success' then "alert-success"
      when 'error' then "alert-danger"
      when 'alert' then "alert-warning"
    end

    base_class + type_class
  end

  def get_regencies_options(order)
    options = ['']

    if order.address.province.present?
      options = options.concat(REGENCIES[order.address.province])
    end

    return options
  end

  def get_districts_options(order)
    options = ['']

    if order.address.city.present?
      options = options.concat(DISTRICTS[order.address.city])
    end

    return options
  end
end
