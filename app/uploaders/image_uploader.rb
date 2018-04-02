class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'NoImageAvailable.png'
  end

  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fit: [248, 180]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
