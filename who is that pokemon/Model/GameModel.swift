//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Alvaro Cuiza on 19/2/23.
//

import Foundation

struct GameModel {
    var score:Int
    
    func getScore() -> Int{
        return self.score
    }
    mutating func setScore(_ newScore :Int){
        self.score = newScore
    }
    mutating func isCorrectAnswer(_ userAnswer :String, _ answerCorrect :String) -> Bool{
        if(userAnswer.uppercased() == answerCorrect.uppercased())
        {
            self.score = self.score + 1
            return true
        }
        return false
    }
}
