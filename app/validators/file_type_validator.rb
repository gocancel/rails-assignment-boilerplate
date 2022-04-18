class FileTypeValidator < ActiveModel::EachValidator
  FILE_NAME_REGEX = /^[\w\-. ]+$/
  def validate_each(record, attribute, value)
    @file_blob = value.blob
    record.errors.add(attribute, "File name invalid") unless file_name_format_valid?
    if options.key?(:image)
      record.errors.add(attribute, "File is not an image") unless file_is_an_image?
    end
    if options.key?(:blacklist)
      record.errors.add(attribute, "Unsupported file type") if file_type_in_blacklist?(options[:blacklist])
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
