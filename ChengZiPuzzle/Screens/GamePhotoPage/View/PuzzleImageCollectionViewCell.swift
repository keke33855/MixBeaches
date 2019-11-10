//
//  PuzzleImageCollectionViewCell.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/10/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit

class PuzzleImageCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var puzzleImgView: UIImageView!

    func configure(with puzzle: Puzzle) {
        puzzleImgView.image = puzzle.image
    }
}
