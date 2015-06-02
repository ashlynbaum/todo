require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery List", description: "Groceries")}

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end
  end

  it "displays no items when the todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(0)
  end

  it "displays item content when a todolist has items" do
    todo_list.todo_items.create(content: "Avocados")
    todo_list.todo_items.create(content: "Bread")

    visit_todo_list(todo_list)

    expect(page.all("ul.todo_items li").size).to eq(2)

    within "ul.todo_items" do
      expect(page).to have_content("Avocados")
      expect(page).to have_content("Bread")
    end
  end

end