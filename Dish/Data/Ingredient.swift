import Foundation

struct Ingredient: Identifiable, Equatable, Codable, Hashable {
    var id: UUID = UUID()
    let name: String
    let amount: Double // Quantity
    let unit: String // Measurement unit (e.g., "g", "tbsp", "cup")
}
