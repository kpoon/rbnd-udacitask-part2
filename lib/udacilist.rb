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
        @items.push TodoItem.new(description, options) 
      end
    elsif type == "event"
      @items.push EventItem.new(description, options) 
    elsif type == "link"
      @items.push LinkItem.new(description, options) 
    else
      raise UdaciListErrors::InvalidItemType 
    end  
  end

  def delete(index)
    if index > @items.length
      raise UdaciListErrors::IndexExceedsListSize 
    else  
      @items.delete_at(index - 1)
    end  
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

end
