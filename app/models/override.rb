class Override
  include ActiveModel::Model

  attr_reader(
    :value,
    :active_until
  )

  validates :value, :active_until, presence: true
  validates_numericality_of :value, greater_than: 0

  def value=(v)
    @value = v.to_i
  end

  def active_until=(dt)
    return @active_until = dt if dt.is_a?(DateTime)

    @active_until =
      begin
        DateTime.parse(dt)
      rescue ArgumentError
        nil
      end
  end
end
