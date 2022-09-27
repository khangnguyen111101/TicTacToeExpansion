/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 1
    Author: Nguyen Bao Khang
    ID: s3817970
    Created  date: 12/08/2022
    Last modified: 07/08/2022
    Acknowledgement: Mobiraft (https://mobiraft.com/ios/swiftui/how-to-add-splash-screen-in-swiftui/)
*/

import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var columns: [GridItem] = [GridItem(.flexible())]
    @Published var moves: [Move?] = Array(repeating: nil, count: 36)
    @Published var isGameDisabled = false
    var winPatterns: Set<Set<Int>> = []
    @Published var alertItem: AlertItem?
    @Published var goal: Int? = nil
    @Published var slot: Int? = nil
    @Published var difficulty: Int? = nil
    @Published var match: Match? = nil
    @Published var user: String? = nil

    init (goal: Int, difficulty: Int, user: String) {
        self.goal = goal
        self.slot = goal * goal
        self.columns = Array(repeating: GridItem(.flexible()), count: goal)
        winPatterns = getWinPatterns()
        self.difficulty = difficulty
        match = Match(user: user, goal: goal, difficulty: difficulty == 1 ? "Easy" : "Normal")
    }
    
    func onPlayerMove(for position: Int) {
        // human move processing
        if isSquareChecked(in: moves, forIndex: position) {  return }
        playSound(sound: "bruh-meme", type: "mp3")
        moves[position] = Move(player: .human, boardIndex: position )
        // check for human win result
        if checkWin(for: .human, in: moves) {
            playSound(sound: "win", type: "mp3")
            alertItem = AlertContext.humanWin
            match!.result = "WIN"
            allMatch.append(match!)
            saveMatch()
            return
        }
        // check for draw result
        if checkDraw(in: moves) {
            alertItem = AlertContext.draw
            playSound(sound: "lose", type: "mp3")
            alertItem = AlertContext.draw
            match!.result = "DRAW"
            allMatch.append(match!)
            saveMatch()
            return
        }
        
        // computer move processing
        isGameDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            playSound(sound: "bruh-meme", type: "mp3")
            let computerPosition = computerNextMove(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameDisabled = false
            // check for computer win result
            if checkWin(for: .computer, in: moves) {
                playSound(sound: "lose", type: "mp3")
                alertItem = AlertContext.computerWin
                match!.result = "LOSE"
                allMatch.append(match!)
                saveMatch()
                return
            }
            // check for draw result
            if checkDraw(in: moves) {
                playSound(sound: "lose", type: "mp3")
                alertItem = AlertContext.draw
                match!.result = "DRAW"
                allMatch.append(match!)
                saveMatch()
                return
            }
        }
    }
    
    func getWinPatterns() -> Set<Set<Int>> {
        var result: Set<Set<Int>> = []
        var temp : Set<Int> = []
        
        // horizontal patterns
        for i in (0..<goal!) {
            for j in (0 ..< goal!) {
                temp.insert(j + goal! * i)
            }
            result.insert(temp)
            temp = []
        }
        // vertical patterns
        for i in (0 ..< goal!) {
            for j in (0..<goal!) {
                temp.insert(i + goal! * j)
            }
            result.insert(temp)
            temp = []
        }
        // diagonal patterns
        for i in (0..<goal!) {
            temp.insert((goal! + 1) * i)
        }
        result.insert(temp)
        temp = []
        
        for i in (0..<goal!) {
            temp.insert(goal! + (goal! - 1) * i - 1)
        }
        result.insert(temp)
        temp = []
        
        return result
    }
    
    func isSquareChecked(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where:  {$0?.boardIndex == index})
    }
    /*
        AI Easy: random available slot
        AI Normal:
            - If AI can't win, block
            - If AI can't block, take middle slot
            - If AI can't take middle slot, random available slot
     */
    func computerNextMove(in moves: [Move?]) -> Int {
        if (difficulty == 1) {
            // easy mode
            return easyComputerNextMove()
        } else if (difficulty == 2) {
            // normal mode
            return normalComputerNextMove()
        }
        return 0
    }

    func easyComputerNextMove() -> Int {
        var movePosition = Int.random(in: 0 ..< slot!)
        while isSquareChecked(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0 ..< slot!)
        }
        return movePosition
    }

    func normalComputerNextMove() -> Int {
        // If AI can win, win
        let computerMoves = moves.compactMap{ $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            let winPosition = pattern.subtracting(computerPositions)
            if winPosition.count == 1 {
                let isAvailable = !isSquareChecked(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first! }
            }
        }
        
        // If AI can't win, block
        let humanMoves = moves.compactMap{ $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns {
            let winPosition = pattern.subtracting(humanPositions)
            if winPosition.count == 1 {
                let isAvailable = !isSquareChecked(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first! }
            }
        }
        
        // If AI can't block, take middle slot
        let tacticPoints: [Int]
        if goal! % 2 != 0 {
            tacticPoints = [slot! / 2]
        } else {
            let temp = (slot! - goal!) / 2
            tacticPoints = [temp - 1, temp, temp - 1 + goal!, temp + goal!]
        }
        
        if tacticPoints.count == 1 {
            if !isSquareChecked(in: moves, forIndex: tacticPoints[0]) { return tacticPoints[0] }
        } else {
            for i in tacticPoints {
                if !isSquareChecked(in: moves, forIndex: i) { return i }
            }
        }
        
        // take random slot
        var movePosition = Int.random(in: 0 ..< slot!)
        while isSquareChecked(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0 ..< slot!)
        }
        return movePosition
    }

    func checkWin(for player: Player, in moves: [Move?]) -> Bool {
        let playerMoves = moves.compactMap{ $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map{ $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            return true
        }
        
        return false
    }
    
    func checkDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0 }.count == slot!
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 36 )
    }
}
