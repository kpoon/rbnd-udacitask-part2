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
      if priority != nil and priority != "low" and priority != "high" and priority != "medium"
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
    count = 1
    index_list.each do |index|
      if index > @items.length
        raise UdaciListErrors::IndexExceedsListSize 
      else  
        if count == 1
          @items.delete_at(index - 1)
        else
          @items.delete_at(index - 2)  
        end  
      end 
      count += 1 
    end 
  end

  def all
    puts @title
    rows = []
    @items.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end

  def filter(list_type)
    filtered_list = @items.select!{|item| item.type == "#{list_type}"}
    if @items.length == 0
      puts "There are no items under that list type."
    else
      self.all
    end  
    
  end  

end
