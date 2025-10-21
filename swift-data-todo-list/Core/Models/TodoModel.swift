import Foundation
import SwiftData

@Model
class TodoModel: Identifiable {
    @Attribute(.unique) var id: String
    var text: String
    var createdAt: Date
    var isEdited: Bool
    var isCompleted: Bool
    
    init (
        id: String = UUID().uuidString,
        text: String,
        createdAt: Date = .now,
        isEdited: Bool = false,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.isEdited = isEdited
        self.isCompleted = isCompleted
    }
}
