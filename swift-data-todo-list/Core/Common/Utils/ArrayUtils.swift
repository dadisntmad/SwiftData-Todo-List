import Foundation

final class ArrayUtils {
    static func groupByDate(todos: [TodoModel]) -> [Date: [TodoModel]] {
        return Dictionary(grouping: todos) { todo in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: todo.createdAt)
            return calendar.date(from: components)!
        }
    }
}
