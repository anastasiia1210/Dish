import CoreML

public class Recommender {
    
    func getRecommendedRecipeIDs(userRatings: [Int64: Double], exclude: [Int64]) -> [Int64]{
        do{
            let recommender = try RecipeRecommender(configuration: MLModelConfiguration())
            let input = RecipeRecommenderInput(items: userRatings, k: 200, restrict_: [], exclude: exclude)
            let result = try recommender.prediction(input: input)
            return result.recommendations
        }catch(let error){
            print(error.localizedDescription)
            return []
        }
    }
}
