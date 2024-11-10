//
//  recipeView.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//

import SwiftUI

struct recipeView: View {
    let recipe: Recipe
    
    var body: some View {
        Text("Hello,this is \(recipe.mainInfo.name) recipe")
        }
    }


struct RecipeDetailView_Previews: PreviewProvider {
    @State static var previewRecipe: Recipe = Recipe.sampleData[0]
  static var previews: some View {
    NavigationView {
        recipeView(recipe: previewRecipe)
    }
  }
}
