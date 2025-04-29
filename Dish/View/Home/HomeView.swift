import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State var searchText = ""
    
    var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else {return viewModel.recipes}
        return viewModel.allRecipes.filter{$0.name.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.recipes.isEmpty {
                    ProgressView()
                        .progressViewStyle(.automatic)
                        .scaleEffect(1.5)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(filteredRecipes, id: \.id) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeCard(recipe: recipe)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailsView(recipe: recipe)
            }
            .onAppear {
                print("loaded")
                viewModel.loadRecipes()
                viewModel.loadAllRecipes()
            }
            .searchable(text: $searchText, prompt: "Search...")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
