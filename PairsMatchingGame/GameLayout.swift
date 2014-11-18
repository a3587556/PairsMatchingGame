//
//  GameLayout.swift
//  PairsMatchingGame
//
//  Created by darkgod on 14/11/14.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//

//import Foundation
import UIKit

class GameLayout {
    let grid: [CGRect] = {
        let rows = 5
        let cols = 4
        
        let size = CGSize(width: 65, height: 80)
        
        var rects = [CGRect]()
        for row in 0..<rows {
            for col in 0..<cols {
                let x = 15+Int(size.width)*col+10*col
                let y = 70+Int(size.height)*row+10*row
                rects.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
            }
        }
        
        assert(rects.count == rows*cols,"Should generate a \(cols)x\(rows) grid.")
        return rects
    }()
    
    func forPairs(pairs: Int) -> [CGRect] {
        assert(pairs >= 1 && pairs <= 10)
        // TODO: Return the requested number of rectangles.
        let level = gameLayouts[pairs-1]
        var rects: [CGRect] = []
        
        for (i,rect) in enumerate(self.grid) {
            if (level[i] == 1) {
                rects.append(rect)
            }
        }
        assert(rects.count == pairs*2)
        return rects
    }
    
    private let gameLayouts: [[Int]] = [
        [0,0,0,0,
            0,0,0,0,
            0,1,1,0,
            0,0,0,0,
            0,0,0,0],
        
        [0,0,0,0,
            0,0,0,0,
            1,1,1,1,
            0,0,0,0,
            0,0,0,0],
        
        [0,0,0,0,
            0,1,1,0,
            0,1,1,0,
            0,1,1,0,
            0,0,0,0],
        
        [0,0,0,0,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            0,0,0,0],
        
        [1,0,0,1,
            0,1,1,0,
            1,0,0,1,
            0,1,1,0,
            1,0,0,1],
        
        [0,1,1,0,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            0,1,1,0],
        
        [1,1,1,1,
            1,0,0,1,
            1,0,0,1,
            1,0,0,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,0,0,1,
            1,1,1,1,
            1,0,0,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,1,1,1,
            1,0,0,1,
            1,1,1,1,
            1,1,1,1],
        
        [1,1,1,1,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1,
            1,1,1,1],
    ]
}
