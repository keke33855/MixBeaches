import UIKit
class LaunchViewController: BaseViewController {
    enum NavigationType {
        case top
        case errorHint(String)
        case newVersionHint
    }
    static func instance() -> LaunchViewController {
        let vc = LaunchViewController()
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showTopPage()
    }
    private func showTopPage() {
        let homePage = HomeViewController.instance()
        let idiomNav = UINavigationController(rootViewController: homePage)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = idiomNav
        }
    }
}
private func sp_getMediaData() {
    print("Get Info Success")
}
private func sp_getUsersMostFollowerSuccess() {
    print("Get User Succrss")
}

private func sp_getLoginState() {
    print("Check your Network")
}
