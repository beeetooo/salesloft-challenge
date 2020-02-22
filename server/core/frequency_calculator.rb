module Application
  module Core
    class CalculatorError < StandardError; end
    class InvalidValue < CalculatorError; end
    class EmptyValue < CalculatorError; end
    class ArrayHasInvalidValue < CalculatorError; end

    class FrequencyCalculator
      def get(value)
        raise InvalidValue if value.nil?
        raise EmptyValue if value.empty?

        frequency = get_frequency value

        {
          frequency: frequency,
          chars_in_order: get_chars_in_order(frequency)
        }
      end

      private

      def get_frequency(value)
        if !value.is_a? Array
          calculate_string_frequency value
        else
          begin
            value.each_with_object({}) do |string, acc|
              calculate_string_frequency string, acc
            end
          rescue NoMethodError
            raise ArrayHasInvalidValue
          end
        end
      end

      def calculate_string_frequency(string, frequency = {})
        string.split('').each_with_object(frequency) do |character, acc|
          if acc[character]
            acc[character] += 1
          else
            acc[character] = 1
          end

          acc
        end
      end

      def get_chars_in_order(frequency)
        frequency.sort_by(&:last).reverse
      end
    end
  end
end
