import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var allRecipes: [Recipe] = []
    @Published var isLoading = false
    
    func loadRecipes() {
        recipes = DataManager.shared.fetchRecomendedRecipes()
        
        if recipes.isEmpty {
            DataManager.shared.loadRecipesFromJson()
        }
    }
    
    func loadAllRecipes() {
        allRecipes = DataManager.shared.fetchAllRecipes()
    }
    
    func deleteUserData(){
        DataManager.shared.clearUserData()
    }
}
