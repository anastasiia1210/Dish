//
//  RecipeData+CoreDataProperties.swift
//  Dish
//
//  Created by Anastasiia Lysa on 23.03.2025.
//
//

import Foundation
import CoreData


extension RecipeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeData> {
        return NSFetchRequest<RecipeData>(entityName: "RecipeData")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var rating: Double
    @NSManaged public var descriptionText: String?
    @NSManaged public var calories: Int32
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
    @NSManaged public var category: RecipeCategoryData?

}

extension RecipeData {
    func toRecipe() -> Recipe {
        return Recipe(
            id: Int(id),
            name: name ?? "Без назви",
            category: category?.name ?? "",
            image: image ?? "",
            rating: rating,
            description: descriptionText ?? "",
            calories: Int(calories),
            ingredients: ingredients ?? "",
            instructions: instructions ?? ""
        )
    }
}


extension RecipeData : Identifiable {

}
