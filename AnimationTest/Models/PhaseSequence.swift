//
//  PhaseSequence.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

protocol SequenceObserver: class {
    func timeUpdated(sequence: TimeInterval, phase: TimeInterval)
    func phaseBegan(phase: Phase)
    func sequenceCompleted()
}

class PhaseSequence {
    
    let phases: [Phase]
    let sequenceDuration: Double
    
    weak var observer: SequenceObserver?
    
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
        self.sequenceDuration = phases.reduce(0) {$0 + $1.duration}
    }
    
    func phase(at index: Int) -> Phase? {
        guard (0..<phases.count).contains(index) else {return nil}
        return phases[index]
    }
    
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
        observer?.timeUpdated(sequence: sequenceDuration - timePassed, phase: phaseEndTime - timePassed)
    }
    
    func tick(deltaTime: TimeInterval) {
        timePassed += deltaTime
        let phaseTimeLeft = phaseEndTime - timePassed
        guard phaseTimeLeft <= 0 else {
            observer?.timeUpdated(sequence: sequenceDuration - timePassed, phase: phaseTimeLeft)
            return
        }
        currentPhaseIndex += 1
        guard let phase = currentPhase else {
            observer?.sequenceCompleted()
            return
        }
        observer?.phaseBegan(phase: phase)
        phaseEndTime += phase.duration
        observer?.timeUpdated(sequence: sequenceDuration - timePassed, phase: phaseEndTime - timePassed)
    }
    
}
