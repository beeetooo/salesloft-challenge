require 'test_helper'

require 'server/use-cases/get_emails_characters_frequency'

module Application
  module UseCases
    class FakeGateway
      def all
        [{
          id: 1,
          name: 'Stephen Hawking',
          email: 'aaabbb@cc.dd'
        }, {
          id: 2,
          name: 'Charles Darwin',
          email: 'aaabbb@cc.dd'
        }]
      end
    end

    class GetEmailsCharactersFrequencyTest < Minitest::Test
      def test_get_emails_frequency
        command = GetEmailsCharactersFrequency.new FakeGateway.new

        result = command.execute

        assert_equal ['b', 6], result[0]
        assert_equal ['a', 6], result[1]
        assert_equal ['d', 4], result[2]
        assert_equal ['c', 4], result[3]
        assert_equal ['.', 2], result[4]
        assert_equal ['@', 2], result[5]
      end
    end
  end
end
