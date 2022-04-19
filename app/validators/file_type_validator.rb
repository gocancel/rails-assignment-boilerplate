# frozen_string_literal: true

class FileTypeValidator < ActiveModel::EachValidator
  FILE_NAME_REGEX = /^[\w\-. ]+$/.freeze
  
  attr_reader :file_blob

  def validate_each(record, attribute, value)
    @file_blob = value.blob
    return unless file_blob
    record.errors.add(attribute, 'file name invalid') unless file_name_format_valid?
    record.errors.add(attribute, 'file is not an image') if options.key?(:image) && !file_is_an_image?
    if options.key?(:blacklist) && file_type_in_blacklist?(options[:blacklist])
      record.errors.add(attribute, 'Unsupported file type')
    end
  end

  private

  def file_name_format_valid?
    FILE_NAME_REGEX.match?(file_blob.filename.to_s)
  end

  def file_is_an_image?
    file_blob.image?
  end

  def file_type_in_blacklist?(blacklist)
    blacklist.include? file_blob.content_type
  end
end
