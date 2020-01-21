import UIKit
import RxSwift
class BaseCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
extension BaseCollectionViewCell: XibInstantiatable {}
private func sp_didUserInfoFailed(followCount: String) {
    print("Continue")
}
private func sp_getUsersMostLikedSuccess(string: String) {
    print("Get Info Success")
}

private func sp_upload(followCount: String) {
    print("Continue")
}
