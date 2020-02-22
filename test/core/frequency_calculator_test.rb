require 'test_helper'
require 'server/core/frequency_calculator'

module Application
  module Core
    class FrequencyCalculatorTest < Minitest::Test
      def test_get_character_frequency_of_word
        calculator = FrequencyCalculator.new
        result = calculator.get 'aaabbb@cc.dd'

        frequency = result[:frequency]
        assert_equal 3, frequency['a']
        assert_equal 3, frequency['b']
        assert_equal 2, frequency['c']
        assert_equal 2, frequency['d']
        assert_equal 1, frequency['@']
        assert_equal 1, frequency['.']

        ordered_characters = result[:chars_in_order]
        assert_equal ['b', 3], ordered_characters[0]
        assert_equal ['a', 3], ordered_characters[1]
        assert_equal ['d', 2], ordered_characters[2]
        assert_equal ['c', 2], ordered_characters[3]
        assert_equal ['.', 1], ordered_characters[4]
        assert_equal ['@', 1], ordered_characters[5]
      end

      def test_array_of_strings
        calculator = FrequencyCalculator.new
        result = calculator.get ['aaabbb@cc.dd', 'aaabbb@cc.dd']

        frequency = result[:frequency]
        assert_equal 6, frequency['a']
        assert_equal 6, frequency['b']
        assert_equal 4, frequency['c']
        assert_equal 4, frequency['d']
        assert_equal 2, frequency['@']
        assert_equal 2, frequency['.']

        ordered_characters = result[:chars_in_order]
        assert_equal ['b', 6], ordered_characters[0]
        assert_equal ['a', 6], ordered_characters[1]
        assert_equal ['d', 4], ordered_characters[2]
        assert_equal ['c', 4], ordered_characters[3]
        assert_equal ['.', 2], ordered_characters[4]
        assert_equal ['@', 2], ordered_characters[5]
      end

      def test_null_single_value
        calculator = FrequencyCalculator.new
        assert_raises InvalidValue do
          calculator.get nil
        end
      end

      def test_null_in_array
        calculator = FrequencyCalculator.new
        assert_raises ArrayHasInvalidValue do
          calculator.get ['asd', nil]
        end
      end

      def test_empty_values
        calculator = FrequencyCalculator.new
        invalid_values = ['', []]

        invalid_values.each do |value|
          assert_raises EmptyValue do
            calculator.get value
          end
        end
      end
    end
  end
end
