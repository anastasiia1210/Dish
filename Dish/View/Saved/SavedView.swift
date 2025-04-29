import SwiftUI

struct SavedView: View {
    
    @StateObject var viewModel = SavedViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .onAppear{
                        print("load")
                        viewModel.loadRecipes()
                    }
                }
            }
        }
    }
}
