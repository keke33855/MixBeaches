import UIKit
class GamePhotoSelectViewController: BaseViewController {
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    lazy var localPuzzles: [Puzzle] = {
        return (1...14)
            .map { String($0) }
            .compactMap { imgName -> Puzzle? in
                guard let image = UIImage(named: imgName) else {
                    return nil
                }
                return Puzzle(image: image)
            }
    }()
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PuzzleImageCollectionViewCell.self)
        }
    }
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionLayout.sectionInset = Metric.sectionInset
            collectionLayout.minimumLineSpacing = Metric.minimumLineSpacing
            collectionLayout.minimumInteritemSpacing = Metric.minimumInteritemSpacing
            let itemWidth = (UIScreen.main.bounds.width - (Metric.sectionInset.left + Metric.sectionInset.right) - Metric.minimumInteritemSpacing) / 2
            collectionLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }
    static func instance() -> GamePhotoSelectViewController {
        let vc = GamePhotoSelectViewController.initFromStoryboard()
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func photoLabTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            let alert = Alert()
            alert.show(title: "Hint",
                       message: "Can't open photo library, Maybe you don't have permission.",
                       preferredStyle: .alert,
                       actions: [DefaultAlertAction.ok(nil)],
                       completion: nil)
            return
        }
        imagePicker.sourceType = .photoLibrary
        navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = Alert()
            alert.show(title: "Hint",
                       message: "No camera can use",
                       preferredStyle: .alert,
                       actions: [DefaultAlertAction.ok(nil)],
                       completion: nil)
            return
        }
        imagePicker.sourceType = .camera
        navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    private func gotoGamePage(with puzzle: Puzzle) {
        let gamePage = GameViewController.instance(puzzle: puzzle, gameLevel: UserDefaults.getStoredGameLevel())
        navigationController?.pushViewController(gamePage, animated: true)
    }
}
extension GamePhotoSelectViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localPuzzles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PuzzleImageCollectionViewCell.self, for: indexPath)
        guard let puzzle = localPuzzles.safeElement(indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(with: puzzle)
        return cell
    }
}
extension GamePhotoSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let puzzle = localPuzzles.safeElement(indexPath.row) else {
            return
        }
        gotoGamePage(with: puzzle)
    }
}
extension GamePhotoSelectViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard var image = info[.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        if let editedImage = info[.originalImage] as? UIImage {
            image = editedImage
        }
        dismiss(animated: true) { [weak self] in
            let puzzle = Puzzle(image: image)
            self?.gotoGamePage(with: puzzle)
        }
    }
}
extension GamePhotoSelectViewController {
    struct Metric {
        private init() {}
        static let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 8,
                                                             left: 16,
                                                             bottom: 8,
                                                             right: 16)
        static let minimumLineSpacing: CGFloat = 26
        static let minimumInteritemSpacing: CGFloat = 20
        static let numOfRow: CGFloat = 2
    }
}
private func sp_getUserName() {
    print("Continue")
}
private func sp_checkUserInfo() {
    print("Check your Network")
}

private func sp_checkInfo() {
    print("Get User Succrss")
}
