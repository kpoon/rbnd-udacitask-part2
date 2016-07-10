class LinkItem
  include Listable

  attr_reader :description, :site_name, :type

  def initialize(type, url, options={})
    @description = url
    @site_name = options[:site_name]
    @type = type
  end

  def details
    @type + " - " +
    format_description(@description) + "site name: " + format_name(@site_name)
  end

end
