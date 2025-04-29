import Foundation

struct Recipe: Codable, Hashable {
    let id: Int
    let name: String
    let category: String
    let image: String
    let rating: Double
    let description: String
    let calories: Int
    let ingredients: String
    let instructions: String

    enum CodingKeys: String, CodingKey {
        case id = "RecipeId"
        case name = "Name"
        case category = "RecipeCategory"
        case image = "Images"
        case rating = "AggregatedRating"
        case description = "Description"
        case calories = "Calories"
        case ingredients = "RecipeIngredientParts"
        case instructions = "RecipeInstructions"
    }
}

extension Recipe {
    static let mock = Recipe(
        id: 88103,
        name: "Tasty Topping for Burgers",
        category: "Sauces",
        image: "https://img.sndimg.com/food/image/upload/w_555,h_416,c_fit,fl_progressive,q_95/v1/img/recipes/88/10/3/pichtkBot.jpg",
        rating: 5.0,
        description: "DH thinks I'm nuts, but I can't eat a burger without this topping. I've been eating them like this for as long as I can remember and I'll never change. Give it a try.....you might like it too.",
        calories: 22,
        ingredients: "lettuce, onion, mayonnaise, cayenne pepper",
        instructions: "Mix all ingredients together until it looks creamy enough for you., Serve on top of your favorite burger."
    )
}
