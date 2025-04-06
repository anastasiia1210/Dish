import Foundation
import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var rating: Double = 0
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func setRating(){
        print(rating)
        DataManager.shared.addUserRating(recipeId: Int64(recipe.id), rating: rating)
    }
}
