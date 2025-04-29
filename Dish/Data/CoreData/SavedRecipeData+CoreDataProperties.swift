import Foundation
import CoreData


extension SavedRecipeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedRecipeData> {
        return NSFetchRequest<SavedRecipeData>(entityName: "SavedRecipeData")
    }

    @NSManaged public var id: Int64

}

extension SavedRecipeData : Identifiable {

}

extension ShoppingItemData {
    func toShoppingItem() -> ShoppingItem {
        ShoppingItem(id: self.id, name: self.name, isDone: self.isDone)
    }

    func update(from item: ShoppingItem) {
        self.name = item.name
        self.isDone = item.isDone
    }
}
