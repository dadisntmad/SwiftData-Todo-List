import SwiftUI

struct TodoSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var text: String = ""
    
    var isTextEmpty: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack {
            Capsule()
                .fill(.gray.opacity(0.5))
                .frame(width: 30, height: 4)
                .padding(.top)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .tint(.blue)
                
                Spacer()
                
                Text("New Todo")
                    .bold()
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Done")
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
    }
}

#Preview {
    TodoSheet()
}
