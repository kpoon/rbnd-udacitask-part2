class TodoItem
  include Listable

  attr_reader :description, :due, :priority, :type

  def initialize(type, description, options={})
    @description = description
    @type = type
    
    due_date = options[:due]
    if due_date == nil
      @due = options[:due]
    elsif Chronic.parse(due_date)
      @due = Chronic.parse(due_date)
    else 
      @due = Date.parse(due_date)
    end  

    @priority = options[:priority]
  end

  def details
    @type + " - " +
    format_description(@description) + "due: " +
    format_date(date_type: "todo", due: @due) +
    format_priority(@priority)
  end

end
