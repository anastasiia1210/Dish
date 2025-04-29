import Foundation
import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var rating: Double = 0
    @Published var isSaved: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
        checkIfSaved()
    }
    
    func setRating(){
        print(rating)
        DataManager.shared.addUserRating(recipeId: Int64(recipe.id), rating: rating)
    }
    
    func addSavedRecipe(){
        DataManager.shared.addSaveRecipe(id: Int64(recipe.id))
        isSaved = true
    }
    
    func deleteSavedRecipe(){
        DataManager.shared.deleteSavedRecipe(id: Int64(recipe.id))
        isSaved = false
    }
    
    func checkIfSaved() {
        let savedRecipes = DataManager.shared.fetchSavedRecipes()
        isSaved = savedRecipes.contains { $0.id == recipe.id }
    }
}
