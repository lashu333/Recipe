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
        VStack{
        Text("Hello,this is \(recipe.mainInfo.name) recipe")
        Text("\(recipe.mainInfo.description)")
        Text(recipe.mainInfo.author)
        Image(recipe.mainInfo.imageName)
            .resizable()
            .scaledToFit()
            .frame(width:100 , height:100)
        Text(recipe.mainInfo.price.rawValue)
        Text("\(recipe.mainInfo.time)")
        ForEach (recipe.ingredients, id: \.name) { ingredient in
            Text("\(ingredient.name)")
        }
    }
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
