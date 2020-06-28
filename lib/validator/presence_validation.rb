require_relative 'value_validation'

module Validator
  class PresenceValidation < ValueValidation
  
    def validate_attribute(object, attribute, value)
      if value.nil? == option
        raise_validation_error("`#{ attribute }` should be #{ option ? 'present' : 'nil' }")
      end
    end
  
  end
end
