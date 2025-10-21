import SwiftUI

struct TodoSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var text: String = ""
    
    @Binding var isEditMode: Bool
    @Binding var selectedTodo: TodoModel?
    
    var isTextEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func addTodo() {
        let todo = TodoModel(text: text)
        modelContext.insert(todo)
        try? modelContext.save()
        dismiss()
    }
    
    private func updateTodo() {
        if let todo = selectedTodo {
            todo.text = text
            todo.isEdited = true
        }
        try? modelContext.save()
        isEditMode = false
        dismiss()
        selectedTodo = nil
    }
    
    var body: some View {
        VStack {
            Capsule()
                .fill(.gray.opacity(0.5))
                .frame(width: 30, height: 4)
                .padding(.top)
            
            HStack {
                Button {
                    isEditMode = false
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .tint(.blue)
                
                Spacer()
                
                Text(isEditMode ? "Edit Todo" : "Add Todo")
                    .bold()
                
                Spacer()
                
                Button {
                    if isEditMode {
                        updateTodo()
                    } else {
                        addTodo()
                    }
                } label: {
                    Text(isEditMode ? "Save" : "Done")
                        .fontWeight(.semibold)
                }
                .tint(.blue)
                .disabled(isTextEmpty)
            }
            .padding([.leading, .trailing, .top])
            
            
            Divider()
            
            TextField("Learn SwiftData", text: $text, axis: .vertical)
                .padding()
            
            Spacer()
        }
        .onAppear {
            if !isEditMode {
                return
            }
            
            if let todo = selectedTodo {
                text = todo.text
            }
        }
    }
}

#Preview {
    TodoSheet(isEditMode: .constant(false), selectedTodo: .constant(nil))
}
