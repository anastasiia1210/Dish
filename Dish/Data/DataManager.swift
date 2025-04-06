import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    
    private let container: NSPersistentContainer
    private let recommender: Recommender
    
    init() {
        recommender = Recommender()
        container = NSPersistentContainer(name: "DishModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("❌ Error loading Core Data: \(error.localizedDescription)")
            } else {
                print("✅ Core Data loaded successfully!")
            }
        }
    }
    
    func fetchRecomendedRecipes(_ recipeIDs: [Int64] = []) -> [Recipe] {
        let userRatings = fetchAllUserRatings()
        let recommendedRecipeIds = recommender.getRecommendedRecipeIDs(userRatings: userRatings, exclude: Array(userRatings.keys))
        let context = container.viewContext
        
        // Створюємо запит для отримання рецептів із зазначеними ID
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", recommendedRecipeIds)
        
        do {
            // Виконання запиту
            let recipeData = try context.fetch(fetchRequest)
            return recipeData.map { $0.toRecipe() }
        } catch {
            print("❌ Помилка при отриманні рекомендованих рецептів: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAllUserRatings() -> [Int64: Double] {
            let context = container.viewContext
            let fetchRequest: NSFetchRequest<UserRatingData> = UserRatingData.fetchRequest()
            
            do {
                let ratings = try context.fetch(fetchRequest)
                let result = ratings.reduce(into: [Int64: Double]()) { result, rating in
                    result[rating.recipeId] = rating.rating
                }
                print(result)
                return result
            } catch {
                print("❌ Помилка при отриманні рейтингів: \(error.localizedDescription)")
                return [:]
            }
        }
    
    func addUserRating(recipeId: Int64, rating: Double) {
            let context = container.viewContext
            let fetchRequest: NSFetchRequest<UserRatingData> = UserRatingData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "recipeId == %lld", recipeId)

            do {
                if let existingRating = try context.fetch(fetchRequest).first {
                    existingRating.rating = rating
                } else {
                    let newRating = UserRatingData(context: context)
                    newRating.recipeId = recipeId
                    newRating.rating = rating
                }
                
                try context.save()
            } catch {
                print("❌ Помилка при збереженні рейтингу: \(error.localizedDescription)")
            }
        }
    
    
    func loadRecipesFromJson() {
        guard let filePath = Bundle.main.path(forResource: "healthy_recipes", ofType: "json") else {
            print("File not found")
            return
        }
        
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let recipes = try decoder.decode([Recipe].self, from: data)
            
            saveRecipestoCoreData(from: recipes)
        } catch {
            print("errrror")
        }
    }
    
    func deleteAllUserRatings() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserRatingData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("✅ Усі рейтинги користувача успішно видалено.")
        } catch {
            print("❌ Помилка при видаленні рейтингів: \(error.localizedDescription)")
        }
    }

    
    func saveRecipestoCoreData(from recipes: [Recipe]) {
        let context = container.viewContext
        
        for recipeData in recipes {
            let categoryFetchRequest: NSFetchRequest<RecipeCategoryData> = RecipeCategoryData.fetchRequest()
            categoryFetchRequest.predicate = NSPredicate(format: "name == %@", recipeData.category)
            
            let category: RecipeCategoryData
            if let existingCategory = try? context.fetch(categoryFetchRequest).first {
                category = existingCategory
            } else {
                category = RecipeCategoryData(context: context)
                category.name = recipeData.category
                category.id = UUID()
            }
            
            let recipeFetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
            recipeFetchRequest.predicate = NSPredicate(format: "id == %d", recipeData.id)
            
            if (try? context.fetch(recipeFetchRequest).isEmpty) == true {
                let recipe = RecipeData(context: context)
                recipe.id = Int32(recipeData.id)
                recipe.name = recipeData.name
                recipe.image = recipeData.image
                recipe.rating = recipeData.rating
                recipe.descriptionText = recipeData.description
                recipe.calories = Int32(recipeData.calories)
                recipe.ingredients = recipeData.ingredients
                recipe.instructions = recipeData.instructions
                recipe.category = category
            }
        }
        
        do {
            try context.save()
            print("✅ Рецепти успішно збережено в Core Data")
        } catch {
            print("❌ Помилка при збереженні: \(error.localizedDescription)")
        }
    }
    
//    func clearAllData() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Car")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try container.execute(deleteRequest, with: container.viewContext)
//        } catch let error as NSError {
//            // TODO: handle the error
//        }
//    }


}
