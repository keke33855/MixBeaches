//
//  N00601WebViewController.swift
//  kaiyuan
//
//  Created by kaiyuan on 2019/7/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebViewController: BaseViewController {

    @IBOutlet fileprivate weak var backBtn: UIButton!
    @IBOutlet private weak var previousPageBtn: UIButton!
    @IBOutlet private weak var nextPageBtn: UIButton!
    @IBOutlet private weak var safariBtn: UIButton!
    @IBOutlet private weak var homeBtn: UIButton!
    @IBOutlet private weak var webRootView: UIView!
    @IBOutlet private weak var navigationViewHeight: NSLayoutConstraint!
    
    private var needOpenBySafari = false
    
    lazy var webview: WKWebView = {
        let web = WKWebView(frame: self.webRootView.bounds)
        web.navigationDelegate = self;
        self.webRootView.addSubview(web)
        web.scrollView.bounces = false;
        return web
    }()
    
    private var initialUrl: String!
    private var inputTitle: String?
    private var isNeedUrlScheme: Bool = false
    private var hideNavigationView: Bool = false

    // MARK: - initial
    static func instance(url: String,
                         title: String? = nil,
                         checkUrlScheme: Bool = false,
                         hideNavigationView: Bool = false) -> WebViewController {
        let vc = WebViewController.initFromStoryboard()
        vc.initialUrl = url
        vc.inputTitle = title
        vc.isNeedUrlScheme = checkUrlScheme
        vc.hideNavigationView = hideNavigationView
        return vc
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.webview.frame = self.webRootView.bounds
    }

    func checkSafariPrefix(_ url: String) -> String {
        var truncatedUrl = url
        if url.hasPrefix(Metric.flagOfUseSafari),
            let range = url.range(of: Metric.flagOfUseSafari) {
            let realUrlStr = url.suffix(from: range.upperBound)
            if let subUrl = URL(string: String(realUrlStr)) {
                truncatedUrl = subUrl.absoluteString
                needOpenBySafari = true
            }
        }
        return truncatedUrl
    }
    
    /// show a webview controller present by current top view controller.
    ///
    /// - Parameters:
    ///   - url: target webview url.
    ///   - title: initial webview controller title.
    static func show(with url: String,
                     title: String? = nil,
                     checkUrlScheme: Bool = false,
                     hideNavigationView: Bool = false) {
        print("Debug: 1111")
        let webVC = WebViewController.instance(url: url,
                                               title: title,
                                               checkUrlScheme: checkUrlScheme,
                                               hideNavigationView: hideNavigationView)
        print("Debug: 2222")
        webVC.modalPresentationStyle = .fullScreen
        UIApplication.topViewController?.present(webVC, animated: true, completion: nil)
    }

    private func setupView() {
        navigationViewHeight.constant = hideNavigationView ? 0 : Metric.navigationHeight
        
        print("Debug: 4444: \(initialUrl)")
        initialUrl = checkSafariPrefix(initialUrl)
        print("Debug: 5555: \(initialUrl)")
        guard let url = URL(string: initialUrl)?.addSchemeIfNeeded() else {
            backBtn.sendActions(for: .touchUpOutside)
            return
        }
        
        print("Debug: 666: \(url)")
        if needOpenBySafari {
            print("Debug: 777")
            GCD.after(sec: 1) {
                self.dismiss(animated: true) {
                    print("Debug: 9999")
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            return
        }
        print("Debug: 888")
        
        let request = URLRequest(url: url)
        self.webview.load(request)
    }

    private func bindAction() {
        // input
        backBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        safariBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let url = self?.webview.url else {
                    return
                }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            })
            .disposed(by: disposeBag)
        
        previousPageBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.webview.goBack()
            })
            .disposed(by: disposeBag)
        
        nextPageBtn.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.webview.goForward()
            })
            .disposed(by: disposeBag)
        
        homeBtn.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let url = URL(string: self?.initialUrl ?? "")?.addSchemeIfNeeded() else {
                    return
                }
                let request = URLRequest(url: url)
                self?.webview.load(request)
            })
            .disposed(by: disposeBag)
        
        // output
        webview.rx.observe(Bool.self, "canGoBack")
            .distinctUntilChanged()
            .filterNil()
            .bind(to: previousPageBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        webview.rx.observe(Bool.self, "canGoForward")
            .distinctUntilChanged()
            .filterNil()
            .bind(to: nextPageBtn.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Debug: 33333")
        bindAction()
        setupView()
    }

    private func addCustomHeader(request: URLRequest) -> URLRequest {
        var request = request
        if let userAgent = customWebviewUserAgent() {
            request.setValue(userAgent, forHTTPHeaderField: Metric.userAgentKey)
        }
        return request
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        defer {
            needOpenBySafari = false
        }
        
        guard var url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        let isMaybeUrlScheme = !(url.scheme ?? "").contains("http")
        
        if !needOpenBySafari,
            url.absoluteString.hasPrefix(Metric.flagOfUseSafari),
            let range = url.absoluteString.range(of: Metric.flagOfUseSafari) {
            let realUrlStr = url.absoluteString.suffix(from: range.upperBound)
            if let subUrl = URL(string: String(realUrlStr)) {
                url = subUrl
                needOpenBySafari = true
            }
        }
        
        if isMaybeUrlScheme || needOpenBySafari || navigationAction.targetFrame == nil {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
            
            return
        }
        
        if !(navigationAction.request.value(forHTTPHeaderField: Metric.userAgentKey)?.contains(Metric.userAgentAppFlag) ?? false) {
            let newRequest = addCustomHeader(request: navigationAction.request)
            decisionHandler(.cancel)
            webview.load(newRequest)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("navigation got error: \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("provisional got error: \(error.localizedDescription)")
    }
}

extension WebViewController {
    struct Metric {
        private init() {}
        static let navigationHeight: CGFloat = 44.0
        static let flagOfUseSafari = "safari:"
        static let userAgentAppFlag = "dafaApp"
        static let userAgentKey = "navigator.userAgent"
    }
}
