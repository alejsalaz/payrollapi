module DateHelper
  private

  def format_date(date)
    Date.strptime(date.to_s, '%Y-%m-%d')
  end

  def dates_format
    format_date(start_date)
    format_date(end_date)
  rescue StandardError
    errors.add(
      :base,
      'las fechas deben tener el formato AAAA-MM-DD',
      code: '048'
    )
  end

  def dates_coherence
    return if valid_date?(start_date, :beginning_of_month) && valid_date?(end_date, :end_of_month)

    errors.add(
      :base,
      'las fechas inicial y final corresponden al inicio y fin del mes respectivamente',
      code: '049'
    )
  end

  def valid_date?(date, option)
    format_date(date).eql?(format_date(date).send(option))
  end

  def dates_uniqueness
    return if unique_dates?

    errors.add(
      :base,
      'la empresa solo puede tener un periodo por mes',
      code: '050'
    )
  end

  def unique_dates?
    Period.filter_by_company(company_id).each do |period|
      (format_date(period.start_date)..format_date(period.end_date)).any? do |date|
        return false if [format_date(start_date), format_date(end_date)].include?(date)
      end
    end
  end
end
