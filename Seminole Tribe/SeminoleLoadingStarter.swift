import SwiftUI

struct LoadingOverlay: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            // Фон с градиентом
            BackgroundImageView()
            
            // Темный градиент для контраста
            LinearGradient(
                gradient: Gradient(colors: [
                    .black.opacity(0.3),
                    .black.opacity(0.7)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Логотип сверху
                HStack {
                    Spacer()
                    Image("title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 180, maxHeight: 120)
                        .padding(.top, 60)
                    Spacer()
                }
                
                Spacer()
                
                // Блок с текстом и прогресс-баром
                VStack(alignment: .center, spacing: 20) {
                    Text("Loading: \(Int(progress * 100))%")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(.green)
                        .shadow(radius: 2)
                    
                    // Горизонтальный прогресс-бар
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 12)
                            .foregroundColor(.white.opacity(0.2))
                            .cornerRadius(8)
                        
                        Rectangle()
                            .frame(width: CGFloat(progress) * 300, height: 12)
                            .foregroundColor(.green)
                            .cornerRadius(8)
                            .animation(.easeInOut(duration: 0.3), value: progress)
                    }
                    .frame(width: 300)
                }
                .padding(20)
                .background(
                    Color.black
                        .opacity(0.3)
                        .cornerRadius(20)
                        .blur(radius: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green.opacity(0.6), lineWidth: 1)
                )
                .padding(.bottom, 80)
            }
        }
    }
}

private struct BackgroundImageView: View {
    var body: some View {
        Image("background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    LoadingOverlay(progress: 0.2)
}

