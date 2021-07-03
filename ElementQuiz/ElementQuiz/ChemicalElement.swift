//
//  File.swift
//  ElementQuiz
//
//  Created by wickedRun on 2021/07/03.
//

import Foundation

struct ChemicalElement {
    let symbol: String
    let name: String
    let atomicWeight: Int
    let imageName: String
    
    static func setupDefaultElement() -> [ChemicalElement] {
        var chemicalElements: [ChemicalElement] = []
        let carbon = ChemicalElement(symbol: "C", name: "Carbon", atomicWeight: 6, imageName: "Carbon")
        let gold = ChemicalElement(symbol: "Au", name: "Gold", atomicWeight: 79, imageName: "Gold")
        let chlorine = ChemicalElement(symbol: "Cl", name: "Chlorine", atomicWeight: 17, imageName: "Chlorine")
        let sodium = ChemicalElement(symbol: "Na", name: "Sodium", atomicWeight: 11, imageName: "Sodium")
        
        chemicalElements.append(carbon)
        chemicalElements.append(gold)
        chemicalElements.append(chlorine)
        chemicalElements.append(sodium)
        
        return chemicalElements
    }
}
