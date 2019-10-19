//
//  Reactive+UIViewController.swift
//  nomura
//
//  Created by lio on 2019/6/13.
//  Copyright © 2019 lio. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {

    var viewWillAppear: Observable<Bool> {
        return self.methodInvoked(#selector(self.base.viewWillAppear(_:)))
            .map { $0.first as? Bool ?? false }
            .share(replay: 1, scope: .forever)
    }

    var viewDidAppear: Observable<Bool> {
        return self.methodInvoked(#selector(self.base.viewDidAppear(_:)))
            .map { $0.first as? Bool ?? false }
            .share(replay: 1, scope: .forever)
    }

    var viewWillDisappear: Observable<Bool> {
        return self.methodInvoked(#selector(self.base.viewWillDisappear(_:)))
            .map { $0.first as? Bool ?? false }
            .share(replay: 1, scope: .forever)
    }

    var viewDidDisappear: Observable<Bool> {
        return self.methodInvoked(#selector(self.base.viewDidDisappear(_:)))
            .map { $0.first as? Bool ?? false }
            .share(replay: 1, scope: .forever)
    }

    var viewDidLayoutSubviews: Observable<Void> {
        return self.methodInvoked(#selector(self.base.viewDidLayoutSubviews))
            .map { _ in }
            .share(replay: 1, scope: .forever)
    }

}
