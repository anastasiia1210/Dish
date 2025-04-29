import SwiftUI

public struct AppView: View {

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            
            ShoppingView()
                .tabItem {
                    Image(systemName: "cart")
                }

            SavedView()
                .tabItem {
                    Image(systemName: "bookmark")
                }
        }
        .accentColor(.green)
    }
}

