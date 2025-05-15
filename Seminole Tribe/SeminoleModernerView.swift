import WebKit
import Foundation
import SwiftUI
import Combine

class WebContentLoader: ObservableObject {
    @Published var loadState: WebLoadState = WebLoadState.idle()
    let urlToLoad: URL
    private var cancellables = Set<AnyCancellable>()
    private var progressSubject = PassthroughSubject<Double, Never>()
    private var webViewProvider: (() -> WKWebView)?
    
    init(url: URL) {
        self.urlToLoad = url
        setupProgressListener()
    }
    
    func provideWebView(_ provider: @escaping () -> WKWebView) {
        self.webViewProvider = provider
        startLoading()
    }
    
    private func setupProgressListener() {
        progressSubject
            .removeDuplicates()
            .sink { [weak self] prog in
                guard let self = self else { return }
                if prog < 1.0 {
                    self.loadState = WebLoadState.progress(prog)
                } else {
                    self.loadState = WebLoadState.success()
                }
            }
            .store(in: &cancellables)
    }
    
    private func startLoading() {
        guard let webView = webViewProvider?() else { return }
        let req = URLRequest(url: urlToLoad, timeoutInterval: 15.0)
        self.loadState = WebLoadState.progress(0.0)
        webView.load(req)
        observeWebViewProgress(webView)
    }
    
    private func observeWebViewProgress(_ webView: WKWebView) {
        webView.publisher(for: \.estimatedProgress)
            .sink { [weak self] prog in
                self?.progressSubject.send(prog)
            }
            .store(in: &cancellables)
    }
    
    func setNetworkStatus(_ connected: Bool) {
        if connected && loadState.type == .offline {
            startLoading()
        } else if !connected {
            self.loadState = WebLoadState.offline()
        }
    }
}
