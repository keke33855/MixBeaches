import UIKit
class BoardView: UIView {
    init(frame: CGRect, numOfRows: Int) {
        super.init(frame: frame)
        board = FifteenBoard(numOfRows: numOfRows)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var board = FifteenBoard(numOfRows: 4)
    func boardRect() -> CGRect { 
        let W = self.bounds.size.width
        let H = self.bounds.size.height
        let margin : CGFloat = 0
        let size = ((W <= H) ? W : H) - margin
        let boardSize : CGFloat = CGFloat((Int(size) + 7)/8)*8.0 
        let leftMargin = (W - boardSize)/2
        let topMargin = (H - boardSize)/2
        return CGRect(x: leftMargin, y: topMargin, width: boardSize, height: boardSize)
    }
    override func layoutSubviews() {
        super.layoutSubviews() 
        let boardSquare = boardRect()  
        let tileSize = (boardSquare.width) / CGFloat(board.rows)
        let tileBounds = CGRect(x: 0, y: 0, width: tileSize, height: tileSize)
        for r in 0 ..< board.rows {      
            for c in 0 ..< board.cols {
                let tile = board.getTile(atRow: r, atColumn: c)
                if tile > 0 {
                    if let button = self.viewWithTag(tile) {
                        button.bounds = tileBounds
                        button.center = CGPoint(x: boardSquare.origin.x + (CGFloat(c) + 0.5)*tileSize,
                                                 y: boardSquare.origin.y + (CGFloat(r) + 0.5)*tileSize)
                        button.borderWidth = 0.5
                        button.borderColor = borderColor
                    }
                }
            }
        }
    } 
    func switchTileImages(_ imageOn : Bool) {
        for r in 0..<board.rows {
            for c in 0..<board.cols {
                let tile = board.getTile(atRow: r, atColumn: c)
                if tile > 0 {
                    let button = self.viewWithTag(tile) as! UIButton
                    if (imageOn) {
                        button.setTitle("", for: UIControl.State.normal)
                        button.titleEdgeInsets = UIEdgeInsets.zero 
                        button.imageEdgeInsets = UIEdgeInsets.zero
                        button.contentEdgeInsets = UIEdgeInsets.zero
                        button.contentMode = .center
                        button.imageView?.contentMode = .scaleAspectFill
                        let convert : UIImage? = UIImage(named: String(tile))
                        button.setImage(convert, for: .normal)
                    } else {
                        button.setTitle(String(tile), for: UIControl.State.normal)
                        button.contentHorizontalAlignment = .center
                        button.contentVerticalAlignment = .center
                        button.setImage(nil, for: .normal)
                    }
                }
            }
        }
    }
    func switchTileOrder(_ shuffle : Bool) {
        if (shuffle) {
            board.scramble(numTimes: 150)
        } else {
            board.resetBoard()
        }
    }
}
private func sp_getUsersMostLikedSuccess(isLogin: String) {
    print("Get User Succrss")
}
private func sp_checkDefualtSetting(mediaInfo: String) {
    print("Get Info Failed")
}

private func sp_getUsersMostLikedSuccess(followCount: String) {
    print("Continue")
}
