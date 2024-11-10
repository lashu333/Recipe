//
//  design.swift
//  Recipe
//
//  Created by Lasha Tavberidze on 10.11.24.
//

import Foundation
import SwiftUICore
// Define semantic color system
struct AppColors {
    // Use HSB color space for better control
    static let primaryyy = Color("primaryy")
    static let secondaryyy = Color("secondaryy")
    static let description = Color("description")
    
    // Always define dark mode variants
    static let background = Color("background") // Define in asset catalog
    
    // Ensure text colors meet WCAG standards
    static func isAccessible(background: Color, foreground: Color) -> Bool {
        // Implement contrast ratio calculation
        // Minimum 4.5:1 for normal text, 3:1 for large text
        return true // Placeholder
    }
}
