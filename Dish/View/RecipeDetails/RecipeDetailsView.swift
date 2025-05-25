import SwiftUI
import Kingfisher

struct RecipeDetailsView: View {
    @StateObject var viewModel: RecipeDetailsViewModel
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeDetailsViewModel(recipe: recipe))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                KFImage(URL(string: viewModel.recipe.image))
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.width)
                
                VStack {
                    VStack {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .padding(.top)
                        
                        HStack {
                            Text(viewModel.recipe.category)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .foregroundColor(.green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.15))
                            
                            Spacer()
                            Button(action: {
                                if viewModel.isSaved {
                                    viewModel.deleteSavedRecipe()
                                } else {
                                    viewModel.addSavedRecipe()
                                }
                            }, label: {
                                Image(systemName: viewModel.isSaved ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(viewModel.isSaved ? .green : .gray)
                                    .font(.system(size: 20))
                            })
                            .frame(height: 50)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text(viewModel.recipe.name)
                                .font(.system(size: 29, weight: .bold))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        Text(viewModel.recipe.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        Divider()
                        
                        HStack {
                            StarsView(rating: .constant(viewModel.recipe.rating), isInteractive: false)
                                .font(.system(size: 23))
                            
                            Text(String(format: "%.1f", viewModel.recipe.rating))
                                .font(.system(size: 23, weight: .bold))
    
                            Spacer()
                            Text("\(viewModel.recipe.calories) kcal")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                    
                    VStack {
                        VStack{
                            HStack {
                                Text("Ingredients")
                                    .font(.system(size: 23, weight: .bold))
                                Spacer()
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            
                            ForEach(viewModel.recipe.ingredients.components(separatedBy: ", "), id: \.self) { ingredient in
                                if !ingredient.isEmpty {
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Image(systemName: "cart").foregroundColor(.green)
                                            Text(ingredient)
                                        }
                                        
                                        .padding(.vertical)
                                        
                                        Divider()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            HStack {
                                Button(action: {
                                    viewModel.rating = 5
                                    viewModel.setRating()
                                    ShoppingViewModel().addShoppingItems(names: viewModel.recipe.ingredients.components(separatedBy: ", "))
                                }, label: {
                                    Text("Add to Shopping List")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }).padding(.horizontal, 10)
                                    .padding(.vertical, 8)
                                    .background(Color.green)
                                    .cornerRadius(5)
                            } .padding(.vertical)
                                .padding(.horizontal)
                        }.background(Color.white)
                        
                        VStack{
                            HStack {
                                Text("Instructions")
                                    .font(.system(size: 23, weight: .bold))
                                
                                Spacer()
                            }
                            .padding(.vertical)
                            .padding(.horizontal)
                            
                            ForEach(Array(viewModel.recipe.instructions.components(separatedBy: ", ").enumerated()), id: \.element) { index, instruction in
                                VStack(alignment: .leading) {
                                    HStack{
                                        Text("\(index + 1).")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.green)
                                        
                                        Text(instruction)
                                            .font(.body)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .padding(.vertical)
                                   
                                }
                                .padding(.horizontal)
                            }
                            Divider()
                            VStack{
                                Text("Do you like the recipe?")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .textCase(.uppercase)
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                HStack{
                                    VStack(spacing: 3){
                                        StarsView(rating: $viewModel.rating, isInteractive: true)
                                            .font(.system(size: 23))
                                        Text("Rate it to improve recommendations")
                                            .foregroundColor(.gray).font(.system(size: 9))
                                    }
                                    Spacer()
                                    Button(action: { viewModel.setRating() }, label: {
                                        Text("Save")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }).padding(.horizontal, 8)
                                        .padding(.vertical, 5)
                                        .background(Color.green)
                                        .cornerRadius(5)
                                }.padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(Color.white)
                            
                        } .background(Color.white)
                    }
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(25)
                .offset(y: -35)
            }
        })
        .onAppear{
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .padding(.bottom, 70)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: Recipe.mock)
    }
}
