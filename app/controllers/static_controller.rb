class StaticController < ApplicationController

  def show
    render template: "static/#{params[:page]}"
  end

  # def show
  #   if valid_page?
  #     render template: "pages/#{params[:page]}"
  #   else
  #     render file: "public/404.html", status: :not_found
  #   end
  # end

  # private
  # def valid_page?
  #   File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.erb"))
  # end
end