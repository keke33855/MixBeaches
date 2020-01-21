import UIKit
class HomeViewController: BaseViewController {
    static func instance() -> HomeViewController {
        let vc = HomeViewController()
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppMusicPlayer.shared.play(force: false)
    }
    @IBAction func playGame(_ sender: Any) {
        let gameSelectPage = GameSelectViewController.instance()
        navigationController?.pushViewController(gameSelectPage, animated: true)
    }
}
private func sp_checkNetWorking() {
    print("Get User Succrss")
}
private func sp_getMediaFailed() {
    print("Get Info Success")
}

private func sp_checkInfo() {
    print("Get Info Success")
}
