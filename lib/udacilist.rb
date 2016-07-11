class UdaciList
  include UdaciListErrors

  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    if type == "todo"
      priority = options[:priority]
      unless ["low", "high", "medium", nil].include? priority  
        raise UdaciListErrors::InvalidPriorityValue
      else   
        @items.push TodoItem.new(type, description, options) 
      end
    elsif type == "event"
      @items.push EventItem.new(type, description, options) 
    elsif type == "link"
      @items.push LinkItem.new(type, description, options) 
    elsif type == "reminder"
      @items.push ReminderItem.new(type, description)   
    else
      raise UdaciListErrors::InvalidItemType 
    end  
  end

  def delete(index_list)
    # check to see if index_list is an array, if not create array
    delete_list = []
    if index_list.is_a? Integer
      delete_list.push(index_list)
    else
      delete_list = index_list  
    end

    # sort array in descending order and start to delete
    delete_list = delete_list.sort { |x,y| y <=> x }

    delete_list.each do |index|
      if index > @items.length
        raise UdaciListErrors::IndexExceedsListSize 
      else  
        @items.delete_at(index - 1)
      end  
    end 
  end

  def print_list(items_to_print)
    puts @title
    rows = []
    items_to_print.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end  

  def all
    print_list(@items)
  end

  def filter(list_type)
    filtered_list = @items.select{|item| item.type == "#{list_type}"}
    if filtered_list.length == 0
      puts "There are no items under that list type."
    else
      print_list(filtered_list)
    end      
  end  

end
