//
//  BreatheGererator.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

// Name does not express intentions of class
class BreathGenerator {
    
    private enum Constants {
        static let interval: TimeInterval = 0.1
    }
    
    var isRunning: Bool {
        return timer?.isValid ?? false
    }
    
    private let sequence: PhaseSequence
    
    private var timer: Timer? {
        willSet {
            timer?.invalidate()
        }
    }
    
    init(sequence: PhaseSequence) {
        self.sequence = sequence
    }
    
    func start() {
        guard !isRunning else {
            return
        }
        sequence.start()
        timer = Timer.scheduledTimer(withTimeInterval: Constants.interval, repeats: true) { [weak self] (timer) in
            guard let strongSelf = self else {
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
