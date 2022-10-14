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
    return if (
      Date.strptime(end_date.to_s, '%Y-%m-%d') -
      Date.strptime(start_date.to_s, '%Y-%m-%d')
    ).to_i > 27

    errors.add(
      :base,
      'la fecha inicial debe estar por lo menos 27 días después de la fecha final',
      code: '024'
    )
  end
end
