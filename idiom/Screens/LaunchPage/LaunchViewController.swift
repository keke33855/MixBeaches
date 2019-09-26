//
//  LaunchViewController.swift
//  JiPaiQi
//
//  Created by jf on 2019/9/5.
//  Copyright © 2019 lixi. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    enum NavigationType {
        case top
        case errorHint(String)
        case newVersionHint
    }
    
    private var api = APIs()
    
    static func instance() -> LaunchViewController {
        let vc = LaunchViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkVersion()
    }

    private func checkVersion() {
        api.requestAppVersion()
            .map { appVersion -> NavigationType in
                if let errorMsg = appVersion.message, !errorMsg.isEmpty {
                    return .errorHint(errorMsg)
                }
                
                if let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String,
                    let version = appVersion.version,
                    version > currentVersion {
                    return .newVersionHint
                }
                
                return .top
            }
            .catchErrorJustReturn(.top)
            .subscribe(onSuccess: { [weak self] type in
                switch type {
                case .errorHint(let message):
                    self?.showErrorMessage(message)
                case .newVersionHint:
                    self?.showUpdatableMessage()
                case .top:
                    self?.showTopPage()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func showErrorMessage(_ message: String) {
        if message.isValidUrl {
            WebViewController.show(with: message, title: nil, checkUrlScheme: true, hideNavigationView: true)
        } else {
            let alert = Alert()
            alert.show(title: Metric.alertTitle, message: message, preferredStyle: .alert, actions: [DefaultAlertAction.ok(nil)], completion: nil)
        }
    }
    
    private func showTopPage() {
        let homePage = HomeViewController.instance()
        let idiomNav = UINavigationController(rootViewController: homePage)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = idiomNav
        }
    }
    
    private func showUpdatableMessage() {
        let alert = Alert()
        alert.show(title: Metric.alertTitle,
                   message: Metric.updateInfo,
                   preferredStyle: .alert, actions: [UpdateAlertAction.cancel, UpdateAlertAction.update])
            .subscribe(onNext: { [weak self] (action) in
                switch action {
                case .update:
                    (UIApplication.shared.delegate as? AppDelegate)?.appManager.showAppInStore()
                case .cancel:
                    self?.showTopPage()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension LaunchViewController {
    enum UpdateAlertAction: AlertActionType {
        case update
        case cancel
        
        var title: String? {
            switch self {
            case .update:
                return "更新"
            case .cancel:
                return "取消"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .update:
                return .default
            case .cancel:
                return .cancel
            }
        }
    }
}

extension LaunchViewController {
    struct Metric {
        private init() {}
        static let alertTitle = "提示"
        static let updateInfo = "有新的版本可以更新啦！"
    }
}
