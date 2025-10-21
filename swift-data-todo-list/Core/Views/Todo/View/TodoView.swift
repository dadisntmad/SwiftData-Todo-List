import SwiftUI
import SwiftData

struct TodoView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText = ""
    @State private var isSheetPresented = false
    @State private var isEditMode = false
    @State private var selectedTodo: TodoModel?
    
    @Query(sort: \TodoModel.createdAt, order: .reverse) var todos: [TodoModel] = []
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                if todos.isEmpty {
                    ContentUnavailableView(
                        "No todos found.",
                        systemImage: "shippingbox.fill",
                        description: Text("Add some todos to get started.")
                    )
                }
                
                List {
                    ForEach(ArrayUtils.groupByDate(todos: todos).keys.sorted(), id: \.self) { date in
                        Section(header: Text(date.formatted(date: .complete, time: .omitted))) {
                            
                            let items = ArrayUtils.groupByDate(todos: todos)[date] ?? []
                            
                            ForEach(items, id: \.id) { todo in
                                TaskContainer(todo: todo)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            modelContext.delete(todo)
                                            try? modelContext.save()
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                        .tint(.red)
                                        
                                        Button {
                                            selectedTodo = todo
                                            isEditMode = true
                                            isSheetPresented = true
                                        } label: {
                                            Image(systemName: "pencil")
                                        }
                                        .tint(.gray.opacity(0.5))
                                        
                                        Button {
                                            selectedTodo = todo
                                            
                                            if let newTodo = selectedTodo {
                                                newTodo.isCompleted.toggle()
                                            }
                                            
                                            try? modelContext.save()
                                            
                                            selectedTodo = nil
                                        } label: {
                                            Image(systemName: todo.isCompleted ? "arrow.counterclockwise" : "checkmark")
                                        }
                                        .tint(todo.isCompleted ? .gray : .green)
                                    }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .searchable(text: $searchText)
                
                // Floating add button
                Button {
                    isSheetPresented = true
                } label: {
                    Circle()
                        .frame(width: 70, height: 70)
                        .padding()
                        .foregroundStyle(.black)
                        .overlay {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .imageScale(.large)
                        }
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                TodoSheet(isEditMode: $isEditMode, selectedTodo: $selectedTodo)
            }
        }
        .tint(.black)
    }
}

#Preview {
    TodoView()
}
