module Listable
  # Listable methods go here
  def format_description(description)
  	"#{description}".ljust(30)
  end	

  # take in one or two dates
  def format_date(options={})
  	@date_type = options[:date_type]
  	@start_date = options[:start_date]
  	@end_date = options[:end_date]
  	@due = options[:due]

    if @date_type == "event"
    	dates = @start_date.strftime("%D") if @start_date
    	dates << " -- " + @end_date.strftime("%D") if @end_date
    	dates = "N/A" if !dates
    elsif @date_type == "todo"			
    	dates = @due ? @due.strftime("%D") : "No due date" 
    end
    
    return dates
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:yellow) if priority == "medium"
    value = " ⇩".colorize(:blue) if priority == "low"
    value = "" if !priority
    return value
  end

  def format_name(site_name)
    site_name ? site_name : ""
  end
end
