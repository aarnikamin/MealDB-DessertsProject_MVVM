//
//  DessertListViewModel.swift
//  DessertMeals
//

import Foundation

class DessertListViewModel {
    var dessertListModel: Desserts?

    func getAllDesserts(completion: @escaping () -> ()) {
        guard let endpoint = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return }
        let dataTask = URLSession.shared.dataTask(with: endpoint) { [weak self] (data, response, error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let dessertData = try decoder.decode(Desserts.self, from: data!)
                    self?.dessertListModel = dessertData
                    completion()
                }
                catch {
                    print(error.localizedDescription)
                    }
                }
            }
        dataTask.resume()
    }
    
    func configureName(model: Meal) -> String {
        let name = model.strMeal
        return name
    }
    
    func configureImageUrl(model: Meal) -> String {
        let img = model.strMealThumb
        return img
    }
}
