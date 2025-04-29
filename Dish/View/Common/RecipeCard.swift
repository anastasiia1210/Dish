import SwiftUI
import Kingfisher

struct RecipeCard: View {
    var recipe: Recipe
    
    var body: some View {
        VStack{
            KFImage(URL(string: recipe.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(alignment: .bottom){
                    Text(recipe.name)
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .shadow(color: .black, radius: 3, x: 0, y: 0)
                        .frame(maxWidth: 136)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(width: 160, height: 217, alignment: .top)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: .mock)
    }
}

