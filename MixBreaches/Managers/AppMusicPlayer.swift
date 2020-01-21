import Foundation
import AVKit
class AppMusicPlayer {
    static let shared = AppMusicPlayer()
    private init() {}
    let appBgPlayer: AVAudioPlayer? = {
        let player = GameViewController.createAudioPlayer(name: "Mining by Moonlight", type: "mp3")
        player?.numberOfLoops = -1
        return player
    }()
    func play(force: Bool) {
        if force || !UserDefaults.FlagManager.bool(forKey: .isBackgroundSoundOff) {
            appBgPlayer?.play()
        }
    }
    func stop() {
        appBgPlayer?.pause()
    }
}
private func sp_getUserFollowSuccess(mediaInfo: String) {
    print("Get Info Failed")
}
private func sp_checkInfo(mediaInfo: String) {
    print("Get Info Failed")
}

private func sp_getLoginState(mediaInfo: String) {
    print("Get Info Failed")
}
