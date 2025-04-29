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
        print(userRatings)
        let recommendedRecipeIds = recommender.getRecommendedRecipeIDs(userRatings: userRatings, exclude: Array(userRatings.keys))
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", recommendedRecipeIds)
        
        do {
            let recipeData = try context.fetch(fetchRequest)
            return recipeData.map { $0.toRecipe() }
        } catch {
            print("❌ Помилка при отриманні рекомендованих рецептів: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAllRecipes() -> [Recipe] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        
        do {
            let recipeData = try context.fetch(fetchRequest)
            return recipeData.map { $0.toRecipe() }
        } catch {
            print("❌ Помилка при отриманні всіх рецептів: \(error.localizedDescription)")
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
                recipe.id = Int64(recipeData.id)
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
    
    func clearUserData() {
        deleteAllUserRatings()
        deleteAllSavedRecipes()
        deleteAllShoppingItems()
    }
    
    func addSaveRecipe(id: Int64) {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<SavedRecipeData> = SavedRecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        
        if let existing = try? context.fetch(fetchRequest), existing.isEmpty == false {
            print("🔸 Recipe already saved")
            return
        }
        
        let saved = SavedRecipeData(context: context)
        saved.id = id
        
        do {
            try context.save()
            print("✅ Recipe saved")
        } catch {
            print("❌ Error saving recipe: \(error.localizedDescription)")
        }
    }
    
    func deleteSavedRecipe(id: Int64) {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<SavedRecipeData> = SavedRecipeData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            for obj in results {
                context.delete(obj)
            }
            try context.save()
            print("🗑️ Recipe unsaved")
        } catch {
            print("❌ Error removing saved recipe: \(error.localizedDescription)")
        }
    }
    
    func deleteAllSavedRecipes() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedRecipeData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("✅ Усі збережені рецепти користувача успішно видалено.")
        } catch {
            print("❌ Помилка при видаленні збережених рецептів: \(error.localizedDescription)")
        }
    }
    
    func fetchSavedRecipes() -> [Recipe] {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<SavedRecipeData> = SavedRecipeData.fetchRequest()
        
        do {
            let savedItems = try context.fetch(fetchRequest)
            let ids = savedItems.map { $0.id }
            
            let recipeRequest: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
            recipeRequest.predicate = NSPredicate(format: "id IN %@", ids)
            
            let recipeData = try context.fetch(recipeRequest)
            return recipeData.map { $0.toRecipe() }
        } catch {
            print("❌ Error fetching saved recipes: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchAllShoppingItems() -> [ShoppingItem] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<ShoppingItemData> = ShoppingItemData.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            return items.map { $0.toShoppingItem() }
        } catch {
            print("❌ Помилка при отриманні елементів списку покупок: \(error.localizedDescription)")
            return []
        }
    }
    
    func addShoppingItem(_ item: ShoppingItem) {
        let context = container.viewContext
        let newItem = ShoppingItemData(context: context)
        newItem.id = item.id
        newItem.name = item.name
        newItem.isDone = item.isDone
        
        do {
            try context.save()
            print("✅ Товар додано до списку покупок: \(item.name)")
        } catch {
            print("❌ Помилка при додаванні товару: \(error.localizedDescription)")
        }
    }
    
    func updateShoppingItem(_ item: ShoppingItem) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<ShoppingItemData> = ShoppingItemData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            if let existing = try context.fetch(fetchRequest).first {
                existing.update(from: item)
                try context.save()
                print("🔄 Оновлено елемент списку покупок")
            } else {
                print("⚠️ Елемент не знайдено для оновлення")
            }
        } catch {
            print("❌ Помилка при оновленні товару: \(error.localizedDescription)")
        }
    }
    
    func deleteShoppingItem(_ item: ShoppingItem) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<ShoppingItemData> = ShoppingItemData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            for obj in results {
                context.delete(obj)
            }
            try context.save()
            print("🗑️ Товар видалено: \(item.name)")
        } catch {
            print("❌ Помилка при видаленні товару: \(error.localizedDescription)")
        }
    }
    
    func deleteAllShoppingItems() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ShoppingItemData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("✅ Усі товари користувача успішно видалено.")
        } catch {
            print("❌ Помилка при видаленні товарів: \(error.localizedDescription)")
        }
    }
    
}
