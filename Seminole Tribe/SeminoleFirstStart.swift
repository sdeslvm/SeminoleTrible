import SwiftUI
import Foundation

struct LaunchScreenView: View {
    @StateObject private var loaderVM: WebContentLoader
    
    init(viewModel: WebContentLoader) {
        _loaderVM = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            WebViewContainer(viewModel: loaderVM)
                .opacity(loaderVM.loadState.type == .success ? 1 : 0.5)
            if loaderVM.loadState.type == .progress, let percent = loaderVM.loadState.percent {
                ProgressOverlayView(percent: percent)
            }
            if loaderVM.loadState.type == .error, let err = loaderVM.loadState.error {
                ErrorOverlayView(error: err)
            }
            if loaderVM.loadState.type == .offline {
                OfflineOverlayView()
            }
        }
    }
}

private struct ProgressOverlayView: View {
    let percent: Double
    var body: some View {
        GeometryReader { proxy in
            LoadingOverlay(progress: percent)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .background(Color.black)
        }
    }
}

private struct ErrorOverlayView: View {
    let error: Error
    var body: some View {
        Text("Error: \(error.localizedDescription)").foregroundColor(.red)
    }
}

private struct OfflineOverlayView: View {
    var body: some View {
        Text("")
    }
}
