import SwiftUI
import SwiftData

struct TodoView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            TodoListContainer(
                searchText: searchText,
            )
            .searchable(text: $searchText)
        }
        .tint(.black)
    }
}

#Preview {
    TodoView()
}
