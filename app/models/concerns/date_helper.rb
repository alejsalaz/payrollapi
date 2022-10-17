module DateHelper
  def dates_format
    Date.strptime(start_date.to_s, '%Y-%m-%d')
    Date.strptime(end_date.to_s, '%Y-%m-%d')
  rescue StandardError
    errors.add(
      :base,
      'las fechas deben tener el formato AAAA-MM-DD',
      code: '023'
    )
  end

  def dates_coherence
    dates_difference = (
      Date.strptime(end_date.to_s, '%Y-%m-%d') -
      Date.strptime(start_date.to_s, '%Y-%m-%d')
    ).to_i.abs
    return if dates_difference > 26 && dates_difference < 31

    errors.add(
      :base,
      'las fechas inicial y final corresponden al inicio y fin del mes respectivamente ',
      code: '024'
    )
  end
end
