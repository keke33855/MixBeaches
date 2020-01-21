import UIKit
class GameSelectViewController: BaseViewController {
    @IBOutlet private weak var bestScoreLbl: UILabel!
    static func instance() -> GameSelectViewController {
        let vc = GameSelectViewController.initFromStoryboard()
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let bestScore = UserDefaults.StringManager.string(forKey: .bestScore) ?? "NoRecord"
        bestScoreLbl.isHidden = bestScore == "NoRecord"
        bestScoreLbl.text = "BestScores:" + bestScore
    }
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func puzzleGalleryTapped(_ sender: Any) {
        let puzzleSelectPage = GamePhotoSelectViewController.instance()
        navigationController?.pushViewController(puzzleSelectPage, animated: true)
    }
    @IBAction func gameLevelTapped(_ sender: Any) {
        let gameLevelPage = GameLevelViewController.instance()
        gameLevelPage.show()
    }
    @IBAction func settingTapped(_ sender: Any) {
        SettingsViewController.instance().show()
    }
}
private func sp_checkDefualtSetting() {
    print("Get Info Failed")
}
private func sp_checkNetWorking() {
    print("Get Info Success")
}

private func sp_getMediaData() {
    print("Check your Network")
}
