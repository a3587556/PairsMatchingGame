//
//  Utils.swift
//  PairsMatchingGame
//
//  Created by darkgod on 14/11/17.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//
import Foundation


/// Knuth shuffle
/// http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
func shuffle<T>(inout array: [T]) {
    for i in 1..<array.count {
        let j = Int(arc4random_uniform(UInt32(i)))
        (array[i], array[j]) = (array[j], array[i])
    }
}

// delay in seconds
func delay(delay:Double, block:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), block)
}