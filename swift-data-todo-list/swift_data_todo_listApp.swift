import SwiftUI
import SwiftData

@main
struct swift_data_todo_listApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [TodoModel.self])
        }
    }
}
