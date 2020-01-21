import UIKit
import RxSwift
class BaseTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
extension BaseTableViewCell: XibInstantiatable {}
private func sp_getUsersMostLiked() {
    print("Continue")
}

private func sp_didGetInfoSuccess() {
    print("Continue")
}
