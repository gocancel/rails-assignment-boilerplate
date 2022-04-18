# frozen_string_literal: true

class FileSizeValidator < ActiveModel::EachValidator
  attr_reader :file_blob
  
  def validate_each(record, attribute, value)
    @file_blob = value.blob
    return unless file_blob
    record.errors.add(attribute, "File size is too small") if options.key?(:min_size) && smaller_than_min_size
    record.errors.add(attribute, "File size is too big") if options.key?(:max_size) && bigger_than_max_size
  end

  private

  def smaller_than_min_size
    file_blob.byte_size.bytes < options[:min_size]
  end

  def bigger_than_max_size
    file_blob.byte_size.bytes > options[:max_size]
  end
end
