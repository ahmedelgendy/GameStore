//
//  File.swift
//  GameStore
//
//  Created by Elgendy on 16.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import Foundation

class Throttler {
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    private let queue: DispatchQueue
    private let delay: TimeInterval
    
    init(delay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.delay = delay
        self.queue = queue
    }
    
    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem() {
            block()
        }
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
