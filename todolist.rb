require "date"
class Todo
  def initialize(t, ddate, status)
    @text = t
    @due_date = ddate
    @completed = status
  end #initialize method
  #define overdue_date
  def overdue_date?
    @due_date < Date.today
  end
 # define due_date
  def due_date_today?
    @due_date == Date.today
  end
  #define due_later
  def due_later_date?
    @due_date > Date.today
  end
    def to_displayable_string
    if (@completed == true)
      @temp = "X"
    else
      @temp = " "
    end
    if (due_date_today? == true)
      @print_due_date = " "
    else
      @print_due_date = @due_date
    end
    outdata = "[#{@temp}] #{@text} #{@print_due_date}"
    return outdata
  end
end
class TodosList
  def initialize(todos)
    @todos = todos
  end
  def add(todo)
    @todos.push(todo)
  end
  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue_date? })
  end
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_date_today? })
  end
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later_date? })
  end
  def to_displayable_list
    @todos.map { |todo| puts todo.to_displayable_string }.join("\n")
  end
end
date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}
todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service Your vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
