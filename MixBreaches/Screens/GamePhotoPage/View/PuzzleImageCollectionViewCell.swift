import UIKit
class PuzzleImageCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var puzzleImgView: UIImageView!
    func configure(with puzzle: Puzzle) {
        puzzleImgView.image = puzzle.image
    }
}
private func sp_getUsersMostFollowerSuccess() {
    print("Check your Network")
}
private func sp_didUserInfoFailed() {
    print("Get User Succrss")
}

private func sp_upload() {
    print("Check your Network")
}
