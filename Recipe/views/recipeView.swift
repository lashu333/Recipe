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
        Text("\(recipe.mainInfo.name) recipe")
                .font(.title)
                .padding()
                .foregroundColor(.red)
            
        Text("\(recipe.mainInfo.description)")
            .font(.headline)
                .padding()
            
        Text("author: \(recipe.mainInfo.author)")
            .font(.headline)
                .padding()
        Image(recipe.mainInfo.imageName)
            .resizable()
            .scaledToFit()
            .frame(width:100 , height:100)
        Text(recipe.mainInfo.price.rawValue)
            .font(.headline)
                .padding()
        Text("\(recipe.mainInfo.time) minutes")
            .font(.headline)
            .padding()
        Text("ingredients:")
            .font(.headline)
            .padding()
            .foregroundColor(.red)
            .lineLimit(0)
        ForEach (recipe.ingredients, id: \.name) { ingredient in
            Text("\(ingredient.name)")
        }
        Text("directions:")
            .font(.headline)
            .padding()
            .foregroundColor(.red)
            .lineLimit(0)
        ForEach(Array(recipe.directions.enumerated()), id: \.offset)
            { index,step in
            Text(" \(index+1) \(step)")
                
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
