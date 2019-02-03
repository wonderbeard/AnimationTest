//
//  BreatheGererator.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

class BreathGenerator {
    
    private struct C {
        static let Interval: TimeInterval = 0.1
    }
    
    let sequence: PhaseSequence
    private var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }
    var isRunning: Bool {
        return timer?.isValid ?? false
    }
    
    init(sequence: PhaseSequence) {
        self.sequence = sequence
    }
    
    func start() {
        guard !isRunning else {
            return
        }
        sequence.start()
        timer = Timer.scheduledTimer(withTimeInterval: C.Interval, repeats: true) { [weak self] (timer) in
            guard let strongSelf = self else {
                timer.invalidate()
                return
            }
            strongSelf.sequence.tick(deltaTime: timer.timeInterval)
            if strongSelf.sequence.isCompleted {
                strongSelf.timer = nil
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
}
