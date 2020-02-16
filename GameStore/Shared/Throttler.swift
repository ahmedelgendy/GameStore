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
    private var previousRunDate: Date = .distantPast
    private let queue: DispatchQueue
    private let delay: TimeInterval
    
    init(delay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.delay = delay
        self.queue = queue
    }
    
    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()
        workItem = DispatchWorkItem() { [weak self] in
            self?.previousRunDate = Date()
            block()
        }
        let delayInterval = previousRunDate.timeIntervalSinceNow > delay ? 0 : delay
        queue.asyncAfter(deadline: .now() + Double(delayInterval), execute: workItem)
    }
}
