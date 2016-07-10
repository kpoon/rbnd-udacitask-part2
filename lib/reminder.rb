class ReminderItem
  include Listable

  attr_reader :description, :type

  def initialize(type, description)
    @description = description
    @type = type
  end

  def details
    @type + " - " +
    format_description(@description) 
  end

end
