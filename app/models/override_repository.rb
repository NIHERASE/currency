class OverrideRepository
  KEY = 'currency_override'

  class << self
    def save(override)
      ttl = ttl_delay(override.active_until)
      if ttl == 0
        redis.del(KEY)
        nil
      else
        Redis.current.setex(KEY, ttl, override.value)
      end
    end

    def get
      return unless (value = redis.get(KEY)) && (ttl = redis.ttl(KEY))
      Override.new(value: value, active_until: ttl_is_until(ttl))
    end

    private

    def redis
      Redis.current
    end

    def ttl_delay(dt)
      ttl = dt.to_i - DateTime.now.to_i
      return 0 if ttl <= 0
      ttl
    end

    def ttl_is_until(ttl)
      DateTime.now + ttl.seconds
    end
  end
end
