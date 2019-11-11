//
//  Alert.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import RxSwift

// ----- AlertActionType -----

protocol AlertActionType {
    var title: String? { get }
    var style: UIAlertAction.Style { get }
}

extension AlertActionType {
    var style: UIAlertAction.Style {
        return .default
    }
}

// ----- Action -----

enum DefaultAlertAction: AlertActionType {
    case ok(Error?)
    case no
    case yes

    var title: String? {
        switch self {
        case .ok:
            return "OK"
        case .no:
            return "NO"
        case .yes:
            return "YES"
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .no:
            return .cancel
        default:
            return .default
        }
    }
}

// ----- Alert -----

protocol AlertType: class {
    func show<Action: AlertActionType>(title: String?,
                                       message: String?,
                                       preferredStyle: UIAlertController.Style,
                                       actions: [Action],
                                       completion: ((Action) -> Void)?)

    func show<Action: AlertActionType>(title: String?,
                                       message: String?,
                                       preferredStyle: UIAlertController.Style,
                                       actions: [Action]) -> Observable<Action>
}

final class Alert: AlertType {

    func show<Action>(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style,
                      actions: [Action],
                      completion: ((Action) -> Void)? = nil) where Action: AlertActionType {
        guard let message = message else { return }
        Alert.makeAlertController(title: title,
                                  message: message,
                                  preferredStyle: preferredStyle,
                                  actions: actions,
                                  completion: completion)
    }

    func show<Action>(title: String?,
                      message: String?,
                      preferredStyle: UIAlertController.Style,
                      actions: [Action]) -> Observable<Action> where Action: AlertActionType {
        guard let message = message else { return Observable<Action>.empty() }
        return Observable<Action>.create { observer in
            let alert = Alert.makeAlertController(title: title, message: message, preferredStyle: preferredStyle, actions: actions) { action in
                observer.onNext(action)
                observer.onCompleted()
            }
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }

    @discardableResult
    private static func makeAlertController<Action>(title: String?,
                                                    message: String?,
                                                    preferredStyle: UIAlertController.Style,
                                                    actions: [Action],
                                                    completion: ((Action) -> Void)?) -> UIAlertController where Action: AlertActionType {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                completion?(action)
            }
            alert.addAction(alertAction)
        }

        UIApplication.topViewController?.present(alert, animated: true, completion: nil)

        return alert
    }
}
