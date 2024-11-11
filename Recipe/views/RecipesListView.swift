//
//  ContentView.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//
import SwiftUI
import Foundation

struct RecipesListView: View {
    @StateObject var recipes: RecipesViewModel = .init()
    var body: some View {
        VStack {
            NavigationView {
                List(recipes.recipes) { reci in
                    NavigationLink(destination: recipeView(recipe: reci)) {
                        VStack{
                            Text(reci.mainInfo.name)
                            Text(reci.mainInfo.description)
                            Text("\(reci.mainInfo.time) minutes")
                            Text(reci.mainInfo.author)
                            Image(reci.mainInfo.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(reci.mainInfo.price.rawValue)
                        }
                    }
                }
                .navigationTitle("Recipes")
            }
        }
    }
    
}
