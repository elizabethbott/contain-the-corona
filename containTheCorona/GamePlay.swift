//
//  GamePlay.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/25/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit


//minMove is array of possible spots to move to

/*struct spot{
 var row: Int
 var col: Int
 var distanceToX: Int
 var distanceToY: Int
 var visited: Bool
 
 }*/
struct spot{
    var row: Int
    var col: Int
    
    
    //var distance: Int
    //var distanceToX: Int
    // var distanceToY: Int
    var visited: Bool
    
}

struct grid{
    
    var prevRow: Int
    var prevCol: Int
    
}




class GamePlay{
    
    let plus: Set = [0,2,4,6,8,10]
    let minus: Set = [1,3,5,7,9,11]
    
    func movePiece(row: Int, col: Int){
        print("CORONA MOVED")
        spaceGrid[coronaRow][coronaCol].setImage(UIImage(named: "default"), for: .normal)
        spaceGrid[coronaRow][coronaCol].setImage(UIImage(named: "blocker"), for: .selected)
        spaceGrid[coronaRow][coronaCol].isSelected = false
        
        //change row col to be corona piece
        spaceGrid[row][col].isSelected = true
        
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .normal)
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .selected)
        
        coronaRow = row
        coronaCol = col
        
        
        
    }
    
    func checkForLose() -> Bool { //return true if corona won
        if coronaRow == 0 {
            
            
            print("YOU LOST!")
            // GameViewController().unHide()
            winner = true
            return true
            
        }else if coronaRow == 10 {
            
            
            print("YOU LOST!")
            // GameViewController().unHide()
            winner = true
            return true
            
        }else if coronaCol == 4{
            
            
            print("YOU LOST!")
            //  GameViewController().unHide()
            winner = true
            return true
            
        }
        else if coronaCol == 0 {
            
            
            print("YOU LOST!")
            // GameViewController().unHide()
            winner = true
            return true
        }
        
        
        return false
    }
    
    func isValid(row: Int, col: Int) -> (Bool) {
        
        if (!(spaceGrid[row][col].isSelected)){
          //  movePiece(row: coronaRow - 1, col: coronaCol)
            return true
        }
        
        return false
    }
   /* func south() -> (Bool) {
        if !(spaceGrid[coronaRow + 1][coronaCol].isSelected){
           // movePiece(row: coronaRow + 1, col: coronaCol)
            return true
        }
        
        return false
    }
    func east() -> (Bool) {
        if !(spaceGrid[coronaRow][coronaCol + 1].isSelected){
           // movePiece(row: coronaRow, col: coronaCol + 1)
            return true
        }
        
        return false
    }
    func west() -> (Bool) {
        if !(spaceGrid[coronaRow][coronaCol - 1].isSelected){
            //movePiece(row: coronaRow, col: coronaCol - 1)
            return true
        }
        
        return false
    }*/
    //returns true if even row (row -1 and same) (col can only reach end by west but CANT by east)
    //returns false if odd row (row same and + 1) (col can reach end by east but CANT by west)
    func signCheck(row: Int) -> Bool {
        
        if minus.contains(row){
            return true
        }
        
        return false
    }
    
    func isMovePossible() -> (Bool, Int, Int){
        //currentNode
      //  var optimalPath = [spot]()
        //var path = [[grid]]()
        let g = grid(prevRow: -1, prevCol: -1)
        var path = Array(repeating: Array(repeating: g, count: 5), count: 11)
        
        /*for i in 0...10{
            for x in 0...4{
                path[i][x] = grid(prevRow: -1, prevCol: -1)
            }
        }*/
        var listOfPast = [spot]()
        var minMove = [spot]()
        var tempRow = coronaRow
        var tempCol = coronaCol
        //where corona piece is at
        minMove.append(spot(row: tempRow, col: tempCol,  visited: true))
        listOfPast.append(spot(row: tempRow, col: tempCol,  visited: true))
        
        var first = 0
        
        //
        while((!minMove.isEmpty)){
            var visit = false
            let tempSpot = minMove.popLast()
            tempRow = tempSpot?.row ?? -1 //safekeeping but wont happen cuz always have row
            tempCol = tempSpot?.col ?? -1 //safekeeping but wont happen cuz always have col
            
            if tempRow == -1 || tempCol == -1{ //safekeeping but wont happen cuz always have row and col
                break
            }
            //if first != 0{
            //optimalPath.append(spot(row: tempRow, col: tempCol, visited: true))
                //first += 1
           // }
            if tempRow == 10 || tempRow == 0 || tempCol == 4 || tempCol == 0{
                //move corrona piece
                //find starter to path
               // let temp = optimalPath.first
                //movePiece(row: temp!.row, col: temp!.col)
                var row = tempRow
                var col = tempCol
                while( row != coronaRow || col != coronaCol){
                    let tRow = row
                    let tCol = col
                    if ((path[tRow][tCol].prevRow == coronaRow) && (path[tRow][tCol].prevCol == coronaCol)){
                        break
                    }else{
                      
                        row = path[tRow][tCol].prevRow
                        col = path[tRow][tCol].prevCol
                    }
                }//while
                
                //row and col is where to move to
                
                return (true, row, col)
            }
            //returns true if even row (row -1 and same) (col can only reach end by west but CANT by east)
            //returns false if odd row (row same and + 1) (col can reach end by east but CANT by west)
            
            
            
            let sign = signCheck(row: tempRow)
            var colWest = 0
            var colEast = 1
            if sign{
                colWest = -1
                colEast = 0
                
            }
            //north west
            if isValid(row: tempRow - 1, col: tempCol + colWest){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow - 1 && x.col == tempCol + colWest{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow - 1, col: tempCol + colWest, visited: true))
                    listOfPast.append(spot(row: tempRow - 1, col: tempCol + colWest,  visited: true))
                    //path.append(grid(prevRow: tempRow, prevCol: tempCol))
                   
                    path[tempRow - 1][tempCol + colWest].prevRow = tempRow
                    path[tempRow - 1][tempCol + colWest].prevCol = tempCol
                    //optimalPath.append(spot(row: tempRow - 1, col: tempCol, visited: true))
                    visit = true
                }
            }
            
            //northeast
            if isValid(row: tempRow - 1, col: tempCol + colEast){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow - 1 && x.col == tempCol + colEast{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow - 1, col: tempCol + colEast,visited: true))
                    listOfPast.append(spot(row: tempRow - 1, col: tempCol + colEast, visited: true))
                    
                    path[tempRow - 1][tempCol + colEast].prevRow = tempRow
                    path[tempRow - 1][tempCol + colEast].prevCol = tempCol
                    
                    //optimalPath.append(spot(row: tempRow - 1, col: tempCol, visited: true))
                    visit = true
                }
            }
            
            
            
            
            
            
            //south west
            if isValid(row: tempRow + 1, col: tempCol + colWest){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow + 1 && x.col == tempCol + colWest{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow + 1, col: tempCol + colWest,visited: true))
                    listOfPast.append(spot(row: tempRow + 1, col: tempCol + colWest, visited: true))
                    path[tempRow + 1][tempCol + colWest].prevRow = tempRow
                    path[tempRow + 1][tempCol + colWest].prevCol = tempCol
                    //optimalPath.append(spot(row: tempRow + 1, col: tempCol, visited: true))
                    visit = true
                }
            }
            
            //southeast
            if isValid(row: tempRow + 1, col: tempCol + colEast){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow + 1 && x.col == tempCol + colEast{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow + 1, col: tempCol + colEast,visited: true))
                    listOfPast.append(spot(row: tempRow + 1, col: tempCol + colEast,visited: true))
                    //optimalPath.append(spot(row: tempRow + 1, col: tempCol, visited: true))
                    visit = true
                    path[tempRow + 1][tempCol + colEast].prevRow = tempRow
                    path[tempRow + 1][tempCol + colEast].prevCol = tempCol
                }
            }
            //east
            if isValid(row: tempRow, col: tempCol + 1){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow && x.col == tempCol + 1{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow, col: tempCol + 1, visited: true))
                    listOfPast.append(spot(row: tempRow , col: tempCol + 1, visited: true))
                    //optimalPath.append(spot(row: tempRow, col: tempCol + 1, visited: true))
                    visit = true
                    path[tempRow][tempCol + 1].prevRow = tempRow
                    path[tempRow][tempCol + 1].prevCol = tempCol
                }
            }
            //west
            if isValid(row: tempRow, col: tempCol - 1){
                var past = false
                for (_, x) in listOfPast.enumerated(){
                    if x.row == tempRow && x.col == tempCol - 1{
                        past = true
                        break
                    }
                }
                if (!past){
                    minMove.append(spot(row: tempRow, col: tempCol - 1, visited: true))
                    listOfPast.append(spot(row: tempRow, col: tempCol - 1, visited: true))
                    //optimalPath.append(spot(row: tempRow, col: tempCol - 1, visited: true))
                    visit = true
                    path[tempRow][tempCol - 1].prevRow = tempRow
                    path[tempRow][tempCol - 1].prevCol = tempCol
                }
            }
            
           /* if (!visit){
                optimalPath.removeAll()
            }*/
            first += 1
        }//while
        
        
        
        
        
        
        return (false, -1, -1)
        
    }
    
    func play(){
        
        //while true{
        
        
        //print("LETS PLAY!")
        //user moved so can move corona piece now
        
        
        let sign = signCheck(row: coronaRow)
        var colWest = 0
        var colEast = 1
        if sign{
            colWest = -1
            colEast = 0
            
        }
        //WINING MOVES!
        
        //moving up one to win
        if checkForLose(){
            winner = true
        }
            
        //northwest
        else if coronaRow - 1 == 0  && isValid(row: coronaRow - 1, col: coronaCol + colWest) {
            
            movePiece(row: coronaRow - 1, col: coronaCol + colWest)
           
           
         //northeast
        }else if coronaRow - 1 == 0  && isValid(row: coronaRow - 1, col: coronaCol + colEast){
            
            movePiece(row: coronaRow - 1, col: coronaCol + colEast)
            
            
            //southwest
        }else if coronaRow + 1 == 10  && isValid(row: coronaRow + 1, col: coronaCol + colWest) {
            
            movePiece(row: coronaRow + 1, col: coronaCol + colWest)
            
           //southeast
        }
        else if coronaRow + 1 == 0 && isValid(row: coronaRow + 1, col: coronaCol + colEast){
            
            movePiece(row: coronaRow + 1, col: coronaCol + colEast)
            
            //east
        }else if coronaCol + 1 == 4 && isValid(row: coronaRow, col: coronaCol + 1) {
            
            movePiece(row: coronaRow, col: coronaCol + 1)
            
            
        }//east north
        else if coronaCol + 1 == 4 && colEast == 1 && isValid(row: coronaRow - 1, col: coronaCol + 1) {
        
        movePiece(row: coronaRow - 1, col: coronaCol + 1)
        
        //east south
        }else if coronaCol + 1 == 4 && colEast == 1 && isValid(row: coronaRow + 1, col: coronaCol + 1) {
            
            movePiece(row: coronaRow + 1, col: coronaCol + 1)
            
            
        }
            //west
        else if coronaCol - 1 == 0 && isValid(row: coronaRow, col: coronaCol - 1) {
            
            movePiece(row: coronaRow, col: coronaCol - 1)
            
         
          //west north
        }else if coronaCol - 1 == 0 && colWest == -1 && isValid(row: coronaRow - 1, col: coronaCol - 1) {
            
            movePiece(row: coronaRow - 1, col: coronaCol - 1)
            
            
           //west south
        }else if coronaCol - 1 == 0 && colWest == -1 && isValid(row: coronaRow + 1, col: coronaCol - 1) {
            
            movePiece(row: coronaRow + 1, col: coronaCol - 1)
            
            
            
        }else{
        
            //corona cant win yet so randomly finding a next move
            
            //choose better algorithm instead of random
           let resp =  isMovePossible()
            if (!resp.0){
                //if !moved{
                print("YOU WON!")
                userWon = true
                winner = true
                
                
                    //navigate to difference screen
                    //GameViewController().unHide()
                    
                
                //}
                
            }else{
                
                //can and will move
                
                let tempRow = resp.1
                let tempCol = resp.2
                
                movePiece(row: tempRow, col: tempCol)
                
                /*var start = Int.random(in: 0 ... 3)
                
               // var moved = false
                var count = 0
                
                while count < 4{
                    if start == 0{
                        //northwest
                        if isValid(row: coronaRow - 1, col: coronaCol + colWest){
                            movePiece(row: coronaRow - 1, col: coronaCol + colWest)
                           // moved = true
                            break
                        //northeast
                        }else if isValid(row: coronaRow - 1, col: coronaCol + colEast){
                            movePiece(row: coronaRow - 1, col: coronaCol + colEast)
                            // moved = true
                            break
                        }
                    }else if start == 1{
                        //southWest
                        if isValid(row: coronaRow + 1, col: coronaCol + colWest){
                            movePiece(row: coronaRow + 1, col: coronaCol + colWest)
                           // moved = true
                            break
                        //southEast
                        }else if isValid(row: coronaRow + 1, col: coronaCol + colEast){
                            movePiece(row: coronaRow + 1, col: coronaCol + colEast)
                            // moved = true
                            break
                        }
                    }else if start == 2{
                        if isValid(row: coronaRow, col: coronaCol + 1){
                            movePiece(row: coronaRow, col: coronaCol + 1)
                           // moved = true
                            break
                        }
                    }else if start == 3{
                        if isValid(row: coronaRow, col: coronaCol - 1){
                            movePiece(row: coronaRow, col: coronaCol - 1)
                         //   moved = true
                            break
                        }
                    }
                    
                    count = count + 1
                    start = start + 1
                    if start == 4{
                        start = 0
                    }
                }//while count < 4*/
            }
           
        }//else
        
        userPlayed = false
        
        
        //}
    }//play
    
    
    
    
    
    
    
    
    
    
    
    
    
}
