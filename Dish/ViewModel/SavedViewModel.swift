import Foundation
import SwiftUI

class SavedViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func loadRecipes() {
            recipes = DataManager.shared.fetchSavedRecipes()
    }
}

