import Foundation
import CoreData


extension UserRatingData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRatingData> {
        return NSFetchRequest<UserRatingData>(entityName: "UserRatingData")
    }

    @NSManaged public var rating: Double
    @NSManaged public var recipeId: Int64

}

extension UserRatingData : Identifiable {

}
