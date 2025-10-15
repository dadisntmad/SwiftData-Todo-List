import Foundation
import SwiftData

@Model
class TodoModel: Identifiable {
    @Attribute(.unique) var id: String
    var text: String
    var createdAt: Date
    
    init (id: String = UUID().uuidString, text: String, createdAt: Date = .now) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
    }
}
