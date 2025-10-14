import SwiftUI

struct TaskContainer: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Implement Todo list using SwiftData")
                .lineLimit(2)
                .truncationMode(.tail)
            
            HStack {
                Text("Additional note")
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Spacer()
                
                Text("21:03 PM")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
    }
}

#Preview {
    TaskContainer()
}
