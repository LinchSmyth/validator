require 'validator/version'
require 'validator/presence_validation'
require 'validator/format_validation'

module Validator
  ValidationError = Class.new(StandardError)
  
  VALIDATORS_MAP = {
    presence: PresenceValidation,
    format: FormatValidation
  }
  

  def self.included(base)
    base.instance_variable_set(:@validations, Hash.new { |hh, key| hh[key] = [] })
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    attr_accessor :validations
    
    def validate(*fields, **options)
      fields.each do |field|
        validations[field.to_sym].push(*parse_options(options))
      end
    end
    
    
    private
    
    
    def parse_options(options)
      options.map do |validator, option|
        validator_class = VALIDATORS_MAP[validator]
        
        if validator_class.nil?
          raise ArgumentError, "invalid validator `#{ validator }`, valid are: #{ VALIDATORS_MAP.keys }"
        end
        
        validator_class.new(option)
      end
    end
    
  end

  def valid?
    validate!
  rescue ValidationError
    false
  end

  def validate!
    run_validations
    true
  end
  
  
  private
  
  
  def run_validations
    each_validator do |attribute, validator|
      validator.perform_validation(self, attribute)
    end
  end
  
  # don't like using nested iterations, prefer to create wrapper function for them
  def each_validator
    self.class.validations.each do |attribute, validators|
      validators.each { |validator| yield(attribute, validator) }
    end
  end

end
