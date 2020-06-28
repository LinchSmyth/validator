require 'validator/version'

module Validator
  ValidationError = Class.new(StandardError)
  
  
  def valid?
    raise NotImplementedError
  end
  
  def validate!
    raise NotImplementedError
  end
  

  def self.included(base)
    base.instance_variable_set(:@validations, Hash.new { |hh, key| hh[key] = [] })
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    attr_accessor :validations
    
    def validate(*fields, **options)
      fields.each(field) do |field|
        validations[field.to_sym] << parse_options(options)
      end
    end
    
    
    private
    
    
    def parse_options(options)
      raise NotImplementedError
    end
    
  end
  
end
