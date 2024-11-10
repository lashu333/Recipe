//
//  recipeViewModel.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//

import SwiftUI
import Combine
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = Recipe.sampleData
    
    init() {
        print("RecipesViewModel initialized")
        // Add print statement before loading data
        print("Starting to load recipes")
        // Your loading logic here
        print("Finished loading recipes")
    }
}
