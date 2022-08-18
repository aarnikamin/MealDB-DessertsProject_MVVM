//
//  DessertDetailViewModel.swift
//  DessertMeals
//

import Foundation

class DessertDetailViewModel {
    
    var dessertDetailModel: DessertDetail?
    var idMeal: String = ""
    
    func getDessertDetails(idMeal: String, completion: @escaping () -> ()) {
        guard let endpoint = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            return }
        let dataTask = URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let dessertDetailData = try decoder.decode(DessertDetail.self, from: data!)
                    DispatchQueue.main.async { [weak self] in
                        self?.dessertDetailModel = dessertDetailData
                        completion()
                    }
                }
                catch {
                    print(error.localizedDescription)
                    }
                }
            }
        dataTask.resume()
    }
    
    func configureIngredients(model: MealDetails) -> String {
        let ingredient = self.configureData(data: [ model.strIngredient1,
                                                           model.strIngredient2,
                                                           model.strIngredient3,
                                                           model.strIngredient4,
                                                           model.strIngredient5,
                                                           model.strIngredient6,
                                                           model.strIngredient7,
                                                           model.strIngredient8,
                                                           model.strIngredient9,
                                                           model.strIngredient10,
                                                           model.strIngredient11,
                                                           model.strIngredient12,
                                                           model.strIngredient13,
                                                           model.strIngredient14,
                                                           model.strIngredient15,
                                                           model.strIngredient16,
                                                           model.strIngredient17,
                                                           model.strIngredient18,
                                                           model.strIngredient19,
                                                           model.strIngredient20])
        return ingredient
    }

    func configureMeasurements(model: MealDetails) -> String {
        let measure = self.configureData(data: [ model.strMeasure1,
                                                        model.strMeasure2,
                                                        model.strMeasure3,
                                                        model.strMeasure4,
                                                        model.strMeasure5,
                                                        model.strMeasure6,
                                                        model.strMeasure7,
                                                        model.strMeasure8,
                                                        model.strMeasure9,
                                                        model.strMeasure10,
                                                        model.strMeasure11,
                                                        model.strMeasure12,
                                                        model.strMeasure13,
                                                        model.strMeasure14,
                                                        model.strMeasure15,
                                                        model.strMeasure16,
                                                        model.strMeasure17,
                                                        model.strMeasure18,
                                                        model.strMeasure19,
                                                        model.strMeasure20])
        return measure
    }
    
    func configureInstructions(model: MealDetails) -> String {
        let instructionsLabel = model.strInstructions
        return instructionsLabel
    }
    
    func configureTitles() -> (ingredientTitle: String, measurementTitle: String, instructionsTitle: String) {
        return ("Ingredients", "Measurements", "Instructions")
    }
    
    private func configureData(data: [String?]) -> String {
        var labelString = ""

        for item in data {
            if let item = item {
                if item != " " && !item.isEmpty {
                    labelString += item + ", "
                }
            }
        }
        labelString = String(labelString.dropLast(2))
        return labelString
    }
}
