module ApplicationHelper
  # def resource_name
  #   :user
  # end

  # def resource
  #   @resource ||= User.new
  # end

  # def devise_mapping
  #   @devise_mapping ||= Devise.mappings[:user]
  # end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/svg/#{name}.svg"
    puts "\n\n\n\n\nfile path"
    puts file_path
    if File.exists?(file_path)
      puts "\n\ninif\n\n"
      File.read(file_path).html_safe
    else
      '(not found)'
    end
  end
end
