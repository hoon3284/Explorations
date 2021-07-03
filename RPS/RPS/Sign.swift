//
//  Sign.swift
//  RPS
//
//  Created by wickedRun on 2021/06/28.
//

import Foundation

enum Sign: String {
    case rock = "👊"
    case paper = "🖐"
    case scissor = "✌️"
    
    func randomSign() -> Sign {
        let sign = Int.random(in: 0...2)
        if sign == 0 {
            return .rock
        } else if sign == 1 {
            return .paper
        } else {
            return .scissor
        }
    }
    
    func comparison(anotherSign: Sign) -> GameState {
        switch self {
        case .rock:
            if anotherSign == .paper {
                return .lose
            } else if anotherSign == .scissor {
                return .win
            } else {
                return .draw
            }
        case .paper:
            if anotherSign == .scissor {
                return .lose
            } else if anotherSign == .rock {
                return .win
            } else {
                return .draw
            }
        case .scissor:
            if anotherSign == .rock {
                return .lose
            } else if anotherSign == .paper {
                return .win
            } else {
                return .draw
            }
        }
    }
    
    
}
