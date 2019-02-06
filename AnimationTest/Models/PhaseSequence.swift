//
//  PhaseSequence.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

protocol PhaseSequenceObserver: class {
    func remainingTimeDidChange(currentPhase: TimeInterval, total: TimeInterval)
    func phaseBegan(phase: Phase)
    func sequenceCompleted()
}

// Name does not express intentions of class
class PhaseSequence {
    
    let phases: [Phase]
    let sequenceDuration: Double
    
    weak var observer: PhaseSequenceObserver?
    
    private(set) var currentPhaseIndex: Int = -1
    private(set) var timePassed: TimeInterval = 0.0
    private(set) var phaseEndTime: TimeInterval = 0.0
    
    var currentPhase: Phase? {
        return phase(at: currentPhaseIndex)
    }
    
    var isCompleted: Bool {
        return currentPhase == nil
    }
    
    init(phases: [Phase]) {
        self.phases = phases
        self.sequenceDuration = phases.reduce(0) { $0 + $1.duration }
    }
    
    func phase(at index: Int) -> Phase? {
        return phases.indices.contains(index) ? phases[index] : nil
    }
    
    // What should `start` method do on instance of `PhaseSequence`?
    func start() {
        currentPhaseIndex = 0
        timePassed = 0
        phaseEndTime = 0
        guard let phase = currentPhase else {
            observer?.sequenceCompleted()
            return
        }
        observer?.phaseBegan(phase: phase)
        phaseEndTime += phase.duration
        observer?.remainingTimeDidChange(currentPhase: phaseEndTime - timePassed, total: sequenceDuration - timePassed)
    }
    
    // Hard to understand behavior
    func tick(deltaTime: TimeInterval) {
        timePassed += deltaTime
        let phaseTimeLeft = phaseEndTime - timePassed
        guard phaseTimeLeft <= 0 else {
            observer?.remainingTimeDidChange(currentPhase: phaseTimeLeft, total: sequenceDuration - timePassed)
            return
        }
        currentPhaseIndex += 1
        guard let phase = currentPhase else {
            observer?.sequenceCompleted()
            return
        }
        observer?.phaseBegan(phase: phase)
        phaseEndTime += phase.duration
        observer?.remainingTimeDidChange(currentPhase: phaseEndTime - timePassed, total: sequenceDuration - timePassed)
    }
    
}
