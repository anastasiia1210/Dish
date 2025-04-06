import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    //@State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                //                    TextField("Пошук рецептів...", text: $searchText)
                //                        .padding(10)
                //                        .background(Color(.systemGray6))
                //                        .cornerRadius(10)
                //                        .padding(.horizontal)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                                RecipeCard(recipe: recipe)
                            }
//                            .onAppear {
//                                loadMoreIfNeeded(recipe: recipe)
//                            }
                        }
                        .padding(.horizontal)
//                        if viewModel.isLoading {
//                            ProgressView("Завантаження...")
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical)
//                        }
                    }
                    .onAppear{
                        print("load")
                        viewModel.loadRecipes()
                    }
                }
                //.toolbar(.visible, for: .tabBar)
            }
        }
    }
    
   // private func loadMoreIfNeeded(recipe: Recipe) {
//        guard !viewModel.isLoading else { return }
//        if let lastRecipe = viewModel.recipes.last, recipe.id == lastRecipe.id {
//            viewModel.loadMore()
//        }
      //  }

}
    //struct HomeView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        HomeView(store: .init(initialState: .init()) {
    //            HomeReducer()
    //        })
    //    }
    //}
