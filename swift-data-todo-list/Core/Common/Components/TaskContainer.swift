import SwiftUI

struct TaskContainer: View {
    let todo: TodoModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(todo.text)
                .lineLimit(2)
                .truncationMode(.tail)
            
            HStack {
                Text(todo.createdAt, style: .time)
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    TaskContainer(todo: TodoModel(id: "", text: "", createdAt: .now))
}
