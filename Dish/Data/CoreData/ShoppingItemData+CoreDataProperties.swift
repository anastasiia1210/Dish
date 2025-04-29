import Foundation
import CoreData


extension ShoppingItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItemData> {
        return NSFetchRequest<ShoppingItemData>(entityName: "ShoppingItemData")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var isDone: Bool

}

extension ShoppingItemData : Identifiable {

}
