//
//  Observable+Alert.swift
//  nomura
//
//  Created by liofty on 2019/6/20.
//  Copyright © 2019 lio. All rights reserved.
//

import Foundation
import UIKit

enum RetryAction: AlertActionType {
    case retry
    case cancel(error: Error?)

    var title: String? {
        switch self {
        case .retry:
            return "再試行"
        case .cancel:
            return "キャンセル"
        }
    }

    var style: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        default:
            return .default
        }
    }
}

extension ObservableType {
//    func onAlertError() -> Observable<E> {
//        let disposeBag = DisposeBag()
//        return self.retryWhen { obser -> Observable<Void> in
//            let trigger = PublishSubject<Void>()
//
//            obser.subscribe(onNext: { oError in
//
//                let error: AppError
//                if let err = oError as? AppError {
//                    error = err
//                } else {
//                    error = AppError.make(error: oError)
//                }
//
//                let nextAction = {
//                    trigger.onNext(())
//                }
//
//                let cancelAction = {
//                    trigger.onError(error)
//                    trigger.onCompleted()
//                }
//
//                let title = error.title
//                let msg = error.message
//
//                GCD.main {
//                    let alert = Alert()
//                    switch error {
//                    case .api(let response):
//                        alert.show(title: "\(String(describing: response.status))",
//                            message: response.error,
//                            preferredStyle: .alert,
//                            actions: [RetryAction.cancel(error: error), RetryAction.retry], completion: { action in
//                            switch action {
//                            case .cancel:
//                                cancelAction()
//                            case .retry:
//                                nextAction()
//                            }
//                        })
//                    default:
//                        alert.show(title: title,
//                                   message: msg,
//                                   preferredStyle: .alert,
//                                   actions: [DefaultAlertAction.ok(error)], completion: { action in
//                            switch action {
//                            case .ok:
//                                cancelAction()
//                            default:
//                                break
//                            }
//                        })
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
//
//            return trigger.asObservable()
//        }
//    }
}
