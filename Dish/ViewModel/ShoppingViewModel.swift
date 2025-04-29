import Foundation
import SwiftUI

class ShoppingViewModel: ObservableObject {
    @Published var shoppingItems: [ShoppingItem] = []
    
    func loadShoppingItems() {
        shoppingItems = DataManager.shared.fetchAllShoppingItems()
    }
    
    func addShoppingItem(name: String){
        let newItem = ShoppingItem(name: name)
        DataManager.shared.addShoppingItem(newItem)
        loadShoppingItems()
    }
    
    func addShoppingItems(names: [String]) {
        for name in names {
            let newItem = ShoppingItem(name: name)
            DataManager.shared.addShoppingItem(newItem)
        }
        loadShoppingItems()
    }

    func updateShoppingItem(item: ShoppingItem){
        var updatedItem = item
        updatedItem.isDone.toggle()
        DataManager.shared.updateShoppingItem(updatedItem)
        loadShoppingItems()
    }
    
    func deleteShoppingItem(item: ShoppingItem){
        DataManager.shared.deleteShoppingItem(item)
        loadShoppingItems()
    }
}


