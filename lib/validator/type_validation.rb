require_relative 'value_validation'

module Validator
  class TypeValidation < ValueValidation
    
    def validate_attribute(object, attribute, value)
      unless value.instance_of?(option)
        raise_validation_error("`#{ attribute }` is not instance of #{ option }")
      end
    end
  
  end
end
