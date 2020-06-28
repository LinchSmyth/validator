require_relative 'value_validation'

module Validator
  class FormatValidation < ValueValidation
    
    def validate_attribute(object, attribute, value)
      unless value =~ option
        raise_validation_error("`#{ attribute }` have invalid format")
      end
    end
  
  end
end
