class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Cloudinary::CarrierWave

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fill: [200, 200]

  def extension_whitelist
    %w(jpg jpeg png)
  end
  
  def content_type_whitelist
    /image\//
  end

  def filename
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end
end
