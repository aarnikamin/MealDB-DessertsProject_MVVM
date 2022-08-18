//
//  DessertListStructures.swift
//  DessertMeals
//

import Foundation

struct Desserts: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
