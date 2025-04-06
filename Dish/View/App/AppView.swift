import SwiftUI

public struct AppView: View {

    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }

            SavedView()
                .tabItem {
                    Image(systemName: "bookmark")
                }
        }
        .accentColor(.green)
    }
}

