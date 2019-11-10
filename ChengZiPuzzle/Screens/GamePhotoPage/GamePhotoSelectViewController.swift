//
//  GamePhotoSelectViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/10/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class GamePhotoSelectViewController: BaseViewController {
    
    lazy var localPuzzles: [Puzzle] = {
        return (1...10)
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
            
            let itemWidth = (UIScreen.width - (Metric.sectionInset.left + Metric.sectionInset.right) - Metric.minimumInteritemSpacing) / 2
            collectionLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    // MARK: - Life cycle
    static func instance() -> GamePhotoSelectViewController {
        let vc = GamePhotoSelectViewController.initFromStoryboard()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - actions
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func photoLabTapped(_ sender: Any) {
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
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
