module ApplicationHelper
  def show_svg(path)
    File.open("app/javascript/images/#{path}", "r:UTF-8") do |file|
      raw file.read
    end
  end
end
