import Foundation
import SwiftUI

struct HexColor {
    static func color(from hexString: String) -> Color {
        let cleaned = hexString.trimmingCharacters(in: .alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        return Color(red: r, green: g, blue: b)
    }
    static func uiColor(from hexString: String) -> UIColor {
        let cleaned = hexString.trimmingCharacters(in: .alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

struct MainGameEntryView: View {
    private var gameURL: URL { URL(string: "https://seminoletribe.top/play")! }
    var body: some View {
        ZStack {
            HexColor.color(from: "#DD0000").ignoresSafeArea()
            LaunchScreenView(viewModel: .init(url: gameURL))
        }
    }
}

#Preview {
    MainGameEntryView()
}
