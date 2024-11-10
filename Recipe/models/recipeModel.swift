//
//  recipeModel.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var mainInfo: MainInformation
    var ingredients: [Ingredient] = []
    var directions: [String] = []
    
    struct MainInformation {
        var name: String
        var description: String
        var imageName: String
        var author: String
        var time: Int
        var price: Price
    }
    
    enum Price: String, CaseIterable {
        case low = "$"
        case medium = "$$"
        case high = "$$$"
    }
}

struct Ingredient: Equatable {
    var name: String
    var amount: Double
    var unit: Unit
    
    enum Unit: String, CaseIterable {
        case grams = "g"
        case kilograms = "kg"
        case liters = "l"
        case milliliters = "ml"
    }
}


extension Recipe {
    static let sampleData: [Recipe] = [
        Recipe(
            mainInfo: MainInformation(
                name: "Spaghetti Bolognese",
                description: "A classic Italian pasta dish with rich tomato and meat sauce.",
                imageName: "spaghetti",
                author: "Chef Mario",
                time: 30,
                price: .medium
            ),
            ingredients: [
                Ingredient(name: "Ground Beef", amount: 500, unit: .grams),
                Ingredient(name: "Tomato Sauce", amount: 1, unit: .liters),
                Ingredient(name: "Onion", amount: 1, unit: .kilograms)
            ],
            directions: [
                "Heat oil in a large skillet over medium heat.",
                "Add ground beef and cook until browned.",
                "Stir in tomato sauce and simmer for 15 minutes."
            ]
        ),
        Recipe(
            mainInfo: MainInformation(
                name: "Caesar Salad",
                description: "Fresh romaine lettuce with Caesar dressing, croutons, and Parmesan.",
                imageName: "salad",
                author: "Chef Julia",
                time: 15,
                price: .low
            ),
            ingredients: [
                Ingredient(name: "Romaine Lettuce", amount: 200, unit: .grams),
                Ingredient(name: "Caesar Dressing", amount: 100, unit: .milliliters),
                Ingredient(name: "Parmesan", amount: 50, unit: .grams)
            ],
            directions: [
                "Chop lettuce and add to a large bowl.",
                "Toss with Caesar dressing and Parmesan.",
                "Add croutons on top and serve."
            ]
        )
    ]
}


