//
//  ContentView.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 09.11.24.
//
import SwiftUI
import Foundation

// MARK
struct AccessibilityModifiers: ViewModifier {
    let label: String
    let hint: String
    
    func body(content: Content) -> some View {
        content
            .accessibilityLabel(label)
            .accessibilityHint(hint)
            .accessibilityAddTraits(.isButton)
    }
}

// MARK
struct RecipesListView: View {
    @StateObject var reci: RecipesViewModel = .init()
    @State private var animateCards = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(\.sizeCategory) var sizeCategory
    @State private var hapticEngine = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        NavigationView {
            ZStack {
                
                backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: dynamicSpacing) {
                        headerView
                        recipesGrid
                    }
                }
                .scrollDismissesKeyboard(.immediately)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .onAppear {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                    animateCards = true
                }
            }
        }
    }
    
    // MARK
    
    private var dynamicSpacing: CGFloat {
        switch sizeCategory {
        case .accessibilityExtraExtraExtraLarge: return 40
        case .accessibilityExtraExtraLarge: return 35
        case .accessibilityExtraLarge: return 30
        default: return 24
        }
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: colorScheme == .dark ?
                [Color.black, Color(.systemGray6)] :
                [Color(.systemBackground), Color(.systemGray6).opacity(0.5)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var headerView: some View {
        Text("Delicious")
            .font(.system(size: 40, weight: .bold, design: .serif))
            .foregroundStyle(
                LinearGradient(
                    colors: [.orange, .pink],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 20)
            .accessibility(addTraits: .isHeader)
            .accessibilityLabel("Delicious Recipes")
    }
    
    private var recipesGrid: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 300, maximum: 600), spacing: 20)],
            spacing: 25
        ) {
            ForEach(reci.recipes, id: \.id) { recip in
                RecipeCard(recip: recip)
                    .offset(x: animateCards ? 0 : -UIScreen.main.bounds.width)
                    .opacity(animateCards ? 1 : 0)
                    .animation(
                        .spring(
                            response: 0.8,
                            dampingFraction: 0.7
                        )
                        .delay(Double(reci.recipes.firstIndex(where: { $0.id == recip.id }) ?? 0) * 0.15),
                        value: animateCards
                    )
            }
        }
        .padding(.horizontal)
    }
    
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                hapticEngine.impactOccurred(intensity: 0.7)
            }) {
                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(
                        LinearGradient(colors: [.orange, .pink],
                                     startPoint: .leading,
                                     endPoint: .trailing)
                    )
            }
            .modifier(AccessibilityModifiers(
                label: "Filter Recipes",
                hint: "Double tap to open recipe filters"
            ))
        }
    }
}

// MARK
struct RecipeCard: View {
    let recip: Recipe
    @State private var isPressed = false
    @Environment(\.colorScheme) var colorScheme
    @State private var hapticEngine = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageSection
            contentSection
        }
        .background(cardBackground)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            hapticEngine.impactOccurred(intensity: 0.6)
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    isPressed = false
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(recip.mainInfo.name) recipe")
        .accessibilityHint("Takes \(recip.mainInfo.time) minutes to prepare. Price: \(recip.mainInfo.price.rawValue)")
    }
    
    private var imageSection: some View {
        ZStack(alignment: .bottomLeading) {
            NavigationLink(recip.mainInfo.imageName, destination: recipeView(recipe: recip))
                Image(recip.mainInfo.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                )
            
            HStack(spacing: 12) {
                recipeBadge(icon: "clock.fill", text: "\(recip.mainInfo.time)m")
                recipeBadge(text: recip.mainInfo.price.rawValue)
            }
            .padding(20)
        }
    }
    
    private func recipeBadge(icon: String? = nil, text: String) -> some View {
        HStack(spacing: 4) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.caption)
            }
            Text(text)
                .font(.system(size: 14, weight: .medium))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Material.ultraThinMaterial
                .opacity(0.9)
        )
        .clipShape(Capsule())
    }
    
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(recip.mainInfo.name)
                .font(.title2.weight(.bold))
                .foregroundColor(.primary)
            
            Text(recip.mainInfo.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
           HStack(spacing: 16) {
                actionButton(
                    title: "Save",
                    icon: "bookmark",
                    isPrimary: false
                )
                
               actionButton(
                    title: "Cook Now",
                    icon: "arrow.right",
                    isPrimary: true
               )            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBackground))
                .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.05),
                       radius: 5, x: 0, y: 2)
                .offset(y: -20)
        )
    }
    
    private func actionButton(title: String, icon: String, isPrimary: Bool) -> some View {
        Button(action: {
            hapticEngine.impactOccurred(intensity: 0.5)
        }) {
            Label(title, systemImage: icon)
        }
        .buttonStyle(.bordered)
        .tint(.orange)
        .if(isPrimary) { view in
            view.buttonStyle(.borderedProminent)
        }
        .shadow(color: isPrimary ? .orange.opacity(0.3) : .clear,
                radius: isPrimary ? 5 : 0)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(.systemBackground))
            .shadow(
                color: colorScheme == .dark ? .clear : .black.opacity(0.1),
                radius: 15,
                x: 0,
                y: 5
            )
    }
}

// MARK
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    RecipesListView()
}
