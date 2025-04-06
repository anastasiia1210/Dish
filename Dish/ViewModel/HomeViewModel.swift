import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    
    func loadRecipes() {
       // DataManager.shared.clearAllData()
       // DataManager.shared.loadRecipesFromJson()
        //DataManager.shared.deleteAllUserRatings()
        recipes = DataManager.shared.fetchRecomendedRecipes()
    }
    
    func loadMore() {
        isLoading = true
        print("yes")
       // let recipeIDs: [Int64] = recipes.map { Int64($0.id) }
        recipes = DataManager.shared.fetchRecomendedRecipes([])
        isLoading = false
    }
}
