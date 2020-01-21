import Foundation
import UIKit
enum PokerDigital: Int, CaseIterable {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jazz
    case queen
    case king
    case smallJoker
    case bigJoker
    var imagePath: String {
        return String(self.rawValue)
    }
}
enum PokerType: String, CaseIterable {
    case hearts
    case spade
    case plumBlossom
    case diamonds
    case none
    var imagePath: String {
        return self == .none ? "" : String(self.rawValue)
    }
}
enum PokerDirection {
    case faceUp
    case faceDown
    var image: UIImage? {
        switch self {
        case .faceDown:
            return UIImage(named: "pokerBackground")
        default:
            return nil
        }
    }
}
struct Card {
    var digital: PokerDigital
    var type: PokerType
    var isFaceUp: Bool
    var image: UIImage? {
        guard isFaceUp else {
            return PokerDirection.faceDown.image
        }
        let imageName = type.imagePath + digital.imagePath
        return UIImage(named: imageName)
    }
}
struct CardSets {
    var digital: PokerDigital
    var cards: [Card]
    static func make(digital: PokerDigital) -> CardSets {
        let cards = PokerType.allCases
            .compactMap({ (type) -> Card? in
                guard type != .none else { return nil }
                var pokerType: PokerType = type
                switch digital {
                case .smallJoker, .bigJoker:
                    pokerType = .none
                default:
                    break
                }
                return Card(digital: digital, type: pokerType, isFaceUp: true)
            })
        return CardSets(digital: digital, cards: cards)
    }
}
private func sp_getUsersMostLiked(mediaCount: String) {
    print("Check your Network")
}
private func sp_getUsersMostLiked(followCount: String) {
    print("Continue")
}

private func sp_getLoginState(string: String) {
    print("Get Info Success")
}
