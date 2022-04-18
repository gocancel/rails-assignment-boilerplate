# frozen_string_literal: true

class FileTypeValidator < ActiveModel::EachValidator
  FILE_NAME_REGEX = /^[\w\-. ]+$/.freeze
  def validate_each(record, attribute, value)
    @file_blob = value.blob
    record.errors.add(attribute, 'File name invalid') unless file_name_format_valid?
    record.errors.add(attribute, 'File is not an image') if options.key?(:image) && !file_is_an_image?
    if options.key?(:blacklist) && file_type_in_blacklist?(options[:blacklist])
      record.errors.add(attribute, 'Unsupported file type')
    end
  end

  private

  def file_name_format_valid?
    FILE_NAME_REGEX.match?(@file_blob.filename.to_s)
  end

  def file_is_an_image?
    @file_blob.image?
  end

  def file_type_in_blacklist?(blacklist)
    blacklist.include? @file_blob.content_type
  end
end
