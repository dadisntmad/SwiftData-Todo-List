import SwiftUI
import SwiftData

struct TodoVIew: View {
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
                    ForEach(todos, id: \.id) { todo in
                        TaskContainer(todo: todo)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    modelContext.delete(todo)
                                    try? modelContext.save()
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                                
                                Button {
                                    selectedTodo = todo
                                    isEditMode = true
                                    isSheetPresented = true
                                } label: {
                                    Label("Done", systemImage: "pencil")
                                }
                                .tint(.gray)
                            }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .searchable(text: $searchText)
                
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
    TodoVIew()
}
