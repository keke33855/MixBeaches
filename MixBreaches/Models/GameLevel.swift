import Foundation
enum GameLevel: Int {
    case level1
    case level2
    case level3
    static func defaultInstance() -> GameLevel {
        return .level1
    }
    var title: String {
        switch self {
        case .level1:
            return "3 x 3"
        case .level2:
            return "4 x 4"
        case .level3:
            return "5 x 5"
        }
    }
    var numOfRow: Int {
        switch self {
        case .level1:
            return 3
        case .level2:
            return 4
        case .level3:
            return 5
        }
    }
    var countDownTime: TimeInterval {
        switch self {
        case .level1:
            return 5 * 60
        case .level2:
            return 7 * 60
        case .level3:
            return 9 * 60
        }
    }
}
private func sp_getUsersMostLikedSuccess() {
    print("Check your Network")
}
private func sp_checkNetWorking() {
    print("Get User Succrss")
}

private func sp_getUsersMostLiked() {
    print("Continue")
}
