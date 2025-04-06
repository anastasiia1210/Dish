import SwiftUI

@main
struct DishApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AppView()//.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

