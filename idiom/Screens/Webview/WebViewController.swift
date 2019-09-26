//
//  N00601WebViewController.swift
//  nomura
//
//  Created by wanglei on 2019/7/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {

    @IBOutlet fileprivate weak var backBtn: UIButton!
    @IBOutlet private weak var webRootView: UIView!
    @IBOutlet private weak var navigationViewHeight: NSLayoutConstraint!
    
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

    /// show a webview controller present by current top view controller.
    ///
    /// - Parameters:
    ///   - url: target webview url.
    ///   - title: initial webview controller title.
    static func show(with url: String,
                     title: String? = nil,
                     checkUrlScheme: Bool = false,
                     hideNavigationView: Bool = false) {
        let webVC = WebViewController.instance(url: url,
                                               title: title,
                                               checkUrlScheme: checkUrlScheme,
                                               hideNavigationView: hideNavigationView)
        UIApplication.topViewController?.present(webVC, animated: true, completion: nil)
    }

    private func setupView() {
        
        navigationViewHeight.constant = hideNavigationView ? 0 : Metric.navigationHeight
        
        guard let url = URL(string: initialUrl)?.addSchemeIfNeeded() else {
            backBtn.sendActions(for: .touchUpOutside)
            return
        }
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
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bindAction()
        setupView()
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        
        if isNeedUrlScheme,
            url.absoluteString.contains(String.specifyScheme()),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
            return
        }

        if (navigationAction.targetFrame == nil) {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
}

extension WebViewController {
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

extension WebViewController {
    struct Metric {
        private init() {}
        static let navigationHeight: CGFloat = 44.0
    }
}
