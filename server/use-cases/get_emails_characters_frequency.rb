require 'server/core/frequency_calculator'

module Application
  module UseCases
    class GetEmailsCharactersFrequency
      def initialize(gateway)
        @gateway = gateway
        @calculator = Application::Core::FrequencyCalculator.new
      end

      def execute
        people = @gateway.all
        emails = people.map do |person|
          person[:email]
        end

        result = @calculator.get emails

        result[:chars_in_order]
      end
    end
  end
end
