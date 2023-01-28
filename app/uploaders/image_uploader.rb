class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  
    "https://www.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg"
    # "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQMAAADDCAMAAACxkIT5AAAAolBMVEX///+AgYX+/v5+goX///1+f4N8fH6Cg4atra/y8/SOj5J/f4G+vsGKi42VlZfi4uJ1dXfPz8/Dw8Pi4uSEhIS2trZwcHDZ2dmnp6fJycnt7e2dnZ2UlZjR0dH4+Pjw8PBnZ2fe3t5cXFxvb293dnyxsbOJiI2ko6g7Ozt5eXmsrbJ+fIPEw8i3t7uOjZLo5+svLy8mJiYAAABUVFRGRkZiYmIW0eTyAAAQoUlEQVR4nO1dD3+iuhINWZKIEUFFQVho3Wp7WbvX9969+/2/2stMQLSKBfxXXM793W0ViuRwMjOZTCIhHTp06NChQ4cOHTpUAf0DUN56k/4BBCT47wkOKImD3iPj58+fq940IaUkAAcDlyuk/EHBGOO8b52wBCZRHBhSwXhA6EYJw/ienLIHSgdLw2BSfntAIAeMCeP7CR0om4gcGA/KAUMZMHaKA4I6EA/LQdYngINyx5D1Bd11FGN36LTXA5NZeyroQJ8nlBzE4wHbNqykA8ONrSfr4dDn2NGH1XTgTk5Q1VJQYsucg9MxUsaBQx6OBMUBU6aRndRBwYEADh4PyIFRUQcPz0Ep/iAOOh10Ouh00Omg00Gng04HgE4HnQ4AnQ46HQA6HXQcADoOOg4AHQcdB4DON7ZTB6YJU6DZM9sWTpgwP94o6d1GHZhAAtXVMeolTTQj8Gaj67VTB9vCmcSyrASJyPhocr02ckBN3eDNeBUNh8OoN3Aodoo/SAfYD57GNne5lEJKmbqiN8EO8efogNJkYHPpiXU2gQ4FAb2w6TRgu2wiKkD9Nxnyj1UQjIu5riGsTUXLdKDdQSylIQ6qKeTyV0IaUNAyHWjzP+aHBIASXt1eQimpbRrbpQN8yLF7tBqIqf/cHhScmo/NgWqd47EdGcjip1DUcGUTiFnzqu3iQJFg9aVq7JYGmcMQXDAh+aQ+CW3jgLwvj3"
  end

  # Process files as they are uploaded:
  process scale: [200, 300]
  def scale(width, height)
    resize_to_fill width, height
  end
  #
  # process resize_to_fill: [200, 300]

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end
  # version :large do
  version :large, if: :custom___is_post? do
    process resize_to_fit: [150, 150]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{mounted_as}.jpg" if original_filename
  end

  def custom___is_post?(model = "User", picture = nil)
    model.class.to_s == model
  end
end
