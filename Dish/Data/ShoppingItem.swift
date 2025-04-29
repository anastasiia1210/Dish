import Foundation

struct ShoppingItem: Identifiable, Equatable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var isDone: Bool = false
}
