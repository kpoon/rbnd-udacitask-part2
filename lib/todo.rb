class TodoItem
  include Listable

  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    
    # @due = options[:due] ? Date.parse(options[:due]) : options[:due]
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
    format_description(@description) + "due: " +
    format_date(date_type: "todo", due: @due) +
    format_priority(@priority)
  end

end
