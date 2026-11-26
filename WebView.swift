import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let onSettings: () -> Void

    func makeCoordinator() -> Coordinator { Coordinator(onSettings) }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        let view = WKWebView(frame: .zero, configuration: config)
        view.scrollView.isScrollEnabled = false
        view.scrollView.bounces = false
        view.scrollView.contentInsetAdjustmentBehavior = .never
        view.isOpaque = false
        view.backgroundColor = .black
        view.scrollView.backgroundColor = .black
        view.navigationDelegate = context.coordinator
        let tap = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.fourFingers))
        tap.numberOfTouchesRequired = 4
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        view.load(URLRequest(url: url))
        return view
    }

    func updateUIView(_ view: WKWebView, context: Context) {
        if view.url?.host != url.host || view.url?.port != url.port { view.load(URLRequest(url: url)) }
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        let onSettings: () -> Void
        init(_ onSettings: @escaping () -> Void) { self.onSettings = onSettings }
        @objc func fourFingers() { onSettings() }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            let html = "<body style='background:#000;color:#fff;font:18px -apple-system;text-align:center;padding-top:20vh'>Can't reach the PlayGTA server.<br><small>Tap with four fingers to change the address.</small></body>"
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}
