import SwiftUI

struct TodoVIew: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(0..<50, id: \.self) { _ in
                        TaskContainer()
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    // Delete action
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    // Edit action
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
                    // Add action
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
        }
        .tint(.black)
    }
}

#Preview {
    TodoVIew()
}
