# frozen_string_literal: true

module Parser
  class Errors
    class BaseError < StandardError; end
    class NoConfigurationAvailable < BaseError; end
    class InvalidRow < BaseError; end
    class NoFilePathGiven < BaseError; end
  end
end
