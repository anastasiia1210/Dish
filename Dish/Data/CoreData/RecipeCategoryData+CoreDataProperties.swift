//
//  RecipeCategoryData+CoreDataProperties.swift
//  Dish
//
//  Created by Anastasiia Lysa on 23.03.2025.
//
//

import Foundation
import CoreData


extension RecipeCategoryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeCategoryData> {
        return NSFetchRequest<RecipeCategoryData>(entityName: "RecipeCategoryData")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var recipes: NSSet?

}

// MARK: Generated accessors for recipes
extension RecipeCategoryData {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: RecipeData)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: RecipeData)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}

extension RecipeCategoryData : Identifiable {

}
