module DateHelper
  def valid_dates?
    Date.strptime(start_date.to_s, '%Y-%m-%d')
    Date.strptime(end_date.to_s, '%Y-%m-%d')
  rescue StandardError
    errors.add(
      :base,
      'las fechas deben tener el formato AAAA-MM-DD',
      code: '023'
    )
  end
end
