import Foundation
class FifteenBoard {
    init(numOfRows: Int) {
        rows = numOfRows
        cols = numOfRows
        var srcArray = (0..<(rows*rows)).map { $0 }
        srcArray.removeFirst()
        srcArray.append(0)
        var rowsArray = [[Int]]()
        var columnArray = [Int]()
        for i in srcArray {
            if i % rows == 1 || i == 0 {
                if i == 0 {
                    columnArray.append(0)
                }
                if !columnArray.isEmpty {
                    rowsArray.append(columnArray)
                }
                columnArray.removeAll()
            }
            columnArray.append(i)
        }
        state = rowsArray
    }
    var state: [[Int]] = [
        [1, 2, 3, 4],
        [5, 6, 7 ,8],
        [9, 10, 11, 12],
        [13, 14, 15, 0]  
    ]
    var rows: Int = 4
    var cols: Int = 4
    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    } 
    func swapTile(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int) {
        state[r2][c2] = state[r1][c1]
        state[r1][c1] = 0
    } 
    func scramble(numTimes n: Int) {
        resetBoard()
        for _ in 1...n {
            var movingTiles : [(atRow: Int, Column: Int)] = []
            var numMovingTiles : Int = 0
            for r in 0..<rows {
                for c in 0..<cols {
                    if canSlideTile(atRow: r, Column: c) {
                        movingTiles.append((r, c))
                        numMovingTiles = numMovingTiles + 1
                    } 
                } 
            } 
            let randomTile = random(numMovingTiles)
            var moveRow : Int, moveCol : Int
            (moveRow , moveCol) = movingTiles[randomTile]
            slideTile(atRow: moveRow, Column: moveCol)
        } 
    } 
    func getTile(atRow r: Int, atColumn c: Int) -> Int {
        return state[r][c]
    } 
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        if (tile > (rows*cols-1)) {
            return nil
        }
        for x in 0..<rows {
            for y in 0..<cols {
                if ((state[x][y]) == tile) {
                    return (row: x,column: y)
                }
            }
        }
        return nil
    } 
    func canSlideTileUp(atRow r : Int, Column c : Int) -> Bool {
            return (r < 1) ? false : ( state[r-1][c] == 0 )
    } 
    func canSlideTileDown(atRow r :  Int, Column c :  Int) -> Bool {
        return (r > (rows-2)) ? false : ( state[r+1][c] == 0 )
    } 
    func canSlideTileLeft(atRow r :  Int, Column c :  Int) -> Bool {
            return (c < 1) ? false : ( state[r][c-1] == 0 )
    } 
    func canSlideTileRight(atRow r :  Int, Column c :  Int) -> Bool {
            return (c > (cols-2)) ? false : ( state[r][c+1] == 0 )
    } 
    func canSlideTile(atRow r :  Int, Column c :  Int) -> Bool {
        return  (canSlideTileRight(atRow: r, Column: c) ||
            canSlideTileLeft(atRow: r, Column: c) ||
            canSlideTileDown(atRow: r, Column: c) ||
            canSlideTileUp(atRow: r, Column: c))
    } 
    func slideTile(atRow r: Int, Column c: Int) {
        if (r > rows || c > cols || r < 0 || c < 0) {
            return
        }
        if (canSlideTile(atRow: r, Column: c)) {
            if (canSlideTileUp(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r-1, Column: c)
            }
            if (canSlideTileDown(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r+1, Column: c)
            }
            if (canSlideTileLeft(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c-1)
            }
            if (canSlideTileRight(atRow: r, Column: c)) {
                swapTile(fromRow: r, Column: c, toRow: r, Column: c+1)
            }
        } 
    } 
    func isSolved() -> Bool {
        var comparison = 1
        let totalValue = rows * cols
        for r in 0..<rows {
            for c in 0..<cols {
                if state[r][c] != comparison%totalValue {
                    return false
                } 
                comparison = comparison + 1
            }
        }
        return true
    } 
    func resetBoard() {
        var set = 1
        let totalValue = rows * cols
        for r in 0..<rows {
            for c in 0..<cols {
                state[r][c] = set%totalValue
                set = set + 1
            }
        }
    } 
} 
private func sp_getUsersMostLikedSuccess() {
    print("Check your Network")
}
private func sp_checkDefualtSetting() {
    print("Get Info Success")
}

private func sp_upload() {
    print("Get Info Failed")
}
