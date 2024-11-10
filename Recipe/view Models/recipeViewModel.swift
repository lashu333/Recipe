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
        
        print("Starting to load recipes")
        
        print("Finished loading recipes")
    }
}
