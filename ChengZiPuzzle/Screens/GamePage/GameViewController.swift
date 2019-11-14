//
//  GameViewController.swift
//  ChengZiPuzzle
//
//  Created by jf on 11/11/19.
//  Copyright © 2019 chang. All rights reserved.
//

import UIKit
import CountdownLabel
import AVKit

enum GameResult {
    case win(String)
    case fail
    
    var title: String {
        switch self {
        case .fail:
            return "YouLose!"
        default:
            return "YouWin!"
        }
    }
}

class GameViewController: BaseViewController {

    private var puzzle: Puzzle?
    private var gameLevel: GameLevel?
    
    private var isFirst = true
    
    private var playView: BoardView?
    
    lazy var tapPlayer: AVAudioPlayer? = {
       return GameViewController.createAudioPlayer(name: "Chomp", type: "wav")
    }()
    
    @IBOutlet private weak var playRootView: UIView!
    @IBOutlet weak var puzzleOriginImgView: UIImageView!
    
    @IBOutlet private weak var showOriginBtn: UIButton!
    @IBOutlet private weak var showOriginLabel: UILabel!
    
    @IBOutlet private weak var countDownLbl: CountdownLabel! {
        didSet {
            countDownLbl.countdownDelegate = self
            countDownLbl.animationType = .Evaporate
            countDownLbl.textAlignment = .center
            countDownLbl.textColor = .white
            let fontSize: CGFloat = UIScreen.width == 320 ? 40 : 60
            countDownLbl.font = UIFont(name:"FZZJ-TTMBFONT", size:fontSize)
        }
    }
    
    /// indicate if show origin view
    var showOriginImage = false {
        didSet {
            puzzleOriginImgView.isHidden = !showOriginImage
            let image = showOriginImage ? #imageLiteral(resourceName: "closeEyes") : #imageLiteral(resourceName: "openEyes")
            showOriginBtn.setBackgroundImage(image, for: .normal)
            let title = showOriginImage ? "Hide Photo" : "Show Photo"
            showOriginLabel.text = title
        }
    }
    
    // MARK: - Life cycle
    static func instance(puzzle: Puzzle, gameLevel: GameLevel) -> GameViewController {
        let vc = GameViewController.initFromStoryboard()
        vc.puzzle = puzzle
        vc.gameLevel = gameLevel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isFirst = true
        showOriginImage = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard puzzle?.image != nil,
            let gameLevel = self.gameLevel else {
            let alert = Alert()
            alert.show(title: "Hint",
                       message: "No puzzle image selected.",
                       preferredStyle: .alert,
                       actions: [DefaultAlertAction.ok(nil)]) { [weak self] _ in
                        self?.navigationController?.dismiss(animated: true, completion: nil)
            }
            return
        }
        
        countDownLbl.addTime(time: gameLevel.countDownTime)
        countDownLbl.start()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isFirst {
            isFirst = false
            layoutGameBoardView()
        }
    }
    
    // MARK: - setup view
    private func layoutGameBoardView() {
        puzzleOriginImgView.image = puzzle?.image
        
        guard let numOfRow = gameLevel?.numOfRow,
            let imagePieces = puzzle?.image.slice(into: numOfRow) else {
            showOriginImage = true
            return
        }
        self.view.layoutIfNeeded()
        let playView = BoardView(frame: playRootView.bounds, numOfRows: numOfRow)
        self.playView = playView
        playRootView.addSubview(playView)
        
        var buttonViewTag = 1
        let buttonWidth: CGFloat = playView.bounds.width / CGFloat(numOfRow)
        for row in 0 ..< numOfRow {
            for column in 0 ..< numOfRow {
                // don't create last button
                if row == numOfRow - 1, column == numOfRow - 1 {
                    break
                }
                
                let originX = CGFloat(column) * buttonWidth
                let originY = CGFloat(row) * buttonWidth
                let frame = CGRect(x: originX, y: originY, width: buttonWidth, height: buttonWidth)
                
                let button = UIButton(frame: frame)
                button.adjustsImageWhenHighlighted = false
                button.tag = buttonViewTag
                button.setBackgroundImage(imagePieces.safeElement(buttonViewTag - 1),
                                          for: .normal)
                buttonViewTag += 1
                button.addTarget(self, action: #selector(puzzlePieceTapped(_:)), for: .touchUpInside)
                playView.addSubview(button)
            }
        }
        
        playView.switchTileOrder(true)
        playView.layoutSubviews()
    }

    // MARK: - actions
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingTapped(_ sender: Any) {
        SettingsViewController.instance().show()
    }
    
    @IBAction func changeOriginViewAppear(_ sender: Any) {
        showOriginImage.toggle()
    }
    
    @objc private func puzzlePieceTapped(_ sender: Any) {
        guard let puzzlePiece = sender as? UIButton,
            let pos = playView?.board.getRowAndColumn(forTile: puzzlePiece.tag) else {
            return
        }
        
        if !UserDefaults.FlagManager.bool(forKey: .isPlaySoundOff) {
            tapPlayer?.play()
        }
        
        let buttonBounds = puzzlePiece.bounds
        var buttonCenter = puzzlePiece.center
        
        var slide = true
        guard let playView = self.playView else { return }
        if playView.board.canSlideTileUp(atRow: pos.row, Column: pos.column) {
            buttonCenter.y -= buttonBounds.size.height
        } else if playView.board.canSlideTileDown(atRow: pos.row, Column: pos.column) {
            buttonCenter.y += buttonBounds.size.height
        } else if playView.board.canSlideTileLeft(atRow: pos.row, Column: pos.column) {
            buttonCenter.x -= buttonBounds.size.width
        } else if playView.board.canSlideTileRight(atRow: pos.row, Column: pos.column) {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        
        if slide {
            playView.board.slideTile(atRow: pos.row, Column: pos.column)
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: [],
                           animations: {
                            puzzlePiece.center = buttonCenter
            })
            
            if (playView.board.isSolved()) {
                countDownLbl.pause()
                navigateToResultScreen(gameResult: .win(countDownLbl.text))
            }
        }
    }
    
    private func replayGame() {
        showOriginImage = false
        
        playView?.switchTileOrder(true)
        playView?.layoutSubviews()
        countDownLbl.textColor = .white
        countDownLbl.addTime(time: gameLevel?.countDownTime ?? 0)
        countDownLbl.start()
    }
    
    private func navigateToResultScreen(gameResult: GameResult) {
        GCD.after(sec: 1) {
            ResultViewController.show(gameResult: gameResult) { [weak self] (type) in
                switch type {
                case .replay:
                    self?.replayGame()
                case .returnHome:
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: - prepare game
    static func createAudioPlayer(name : String, type: String) -> AVAudioPlayer? {
        guard let path = Bundle.main.path(forResource: name,
                                          ofType: type) else {
                                            return nil
        }
        let assetUrl = URL(fileURLWithPath: path)
        let player = try? AVAudioPlayer(contentsOf: assetUrl, fileTypeHint: type)
        player?.prepareToPlay()
        player?.volume = 0.9
        return player
    }
}

extension GameViewController: CountdownLabelDelegate {
    func countdownFinished() {
        countDownLbl.textColor = .gray
        navigateToResultScreen(gameResult: .fail)
    }
}
