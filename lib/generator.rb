module Generator
  class << self
    def ticket_random_code
      "#{upper_chars}-#{hex}-#{upper_chars}-#{hex}-#{upper_chars}"
    end

    private

    def hex
      SecureRandom.hex(1).to_s.upcase
    end

    def upper_chars
      ('A'..'Z').to_a.sample(3).join
    end
  end
end # Generator
