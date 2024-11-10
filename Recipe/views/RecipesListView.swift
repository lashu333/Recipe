//
//  ContentView.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//

import SwiftUI
import Foundation

struct RecipesListView: View {
    @StateObject var reci: RecipesViewModel = .init()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(reci.recipes, id: \.id) { recip in
                        VStack(alignment: .leading, spacing: 6) {
                           
                            Text(recip.mainInfo.name)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Text(recip.mainInfo.description)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                                .padding(.top, 2)
                            
                            HStack {
                                Text("\(recip.mainInfo.time) minutes")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text(recip.mainInfo.price.rawValue)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.blue)
                            }
                            .padding(.top, 8)
                        }
                        .padding(16)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .navigationTitle("Recipes")
            .background(Color(UIColor.systemGroupedBackground))
            .onAppear {
                           print("RecipesListView appeared")
                           print("Number of recipes: \(reci.recipes.count)")
                       }
        }
    }
}

#Preview{
    RecipesListView()
}
