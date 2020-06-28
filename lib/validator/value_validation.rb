module Validator
  # ValueValidation
  #
  # base class for defining specific validations.
  # - provided option will be stored as `#option` reader
  # - descendants should implement `#validate_attribute` instance method
  #     accepting object, attribute name and value of that attribute
  # - descendants should raise errors by calling `#raise_validation_error` method with desired message
  #
  class ValueValidation
  
    attr_reader :option
  
    def initialize(option)
      @option = option
    end
  
    def perform_validation(object, attribute)
      value = object.public_send(attribute)
      validate_attribute(object, attribute, value)
    end
  
    def validate_attribute(object, attribute, value)
      raise NotImplementedError, 'descendants must define #validate_attribute method'
    end
    
    def raise_validation_error(msg)
      raise ValidationError, msg
    end
    
  end
end
