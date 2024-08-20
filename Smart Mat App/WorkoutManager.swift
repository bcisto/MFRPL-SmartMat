//
//  WorkoutDisplayView.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 7/4/24.
//

import Combine
import SwiftUI

class WorkoutManager: ObservableObject {
    @Published var upToStep: Int = 0
    @Published var gridColors: [Color] = Array(
        repeating: Color.white, count: 40)
    @Published var buttonText: String = "Start"
    @Published var statusText: String = ""
    @Published var statusColor: Color = Color.green
    @State var isRunning: Bool = false
    var workout: Workout
    var stepStatus: [Bool]

    private var cancellables = Set<AnyCancellable>()

    init(workout: Workout) {
        self.workout = workout
        self.stepStatus = Array(
            repeating: false, count: workout.stepCount)
    }

    @MainActor
    func resetMatColors() {
        DispatchQueue.main.async {
            self.gridColors = Array(
                repeating: Color.white, count: 40)
        }
    }

    @MainActor
    func setMatToRed() {
        DispatchQueue.main.async {
            self.gridColors = Array(
                repeating: Color.red, count: self.workout.stepCount)
        }
    }

    @MainActor
    func reset() {
        resetMatColors()
        resetStepStatus()
        upToStep = 0
        buttonText = "Start"
    }

    func resetStepStatus() {
        self.stepStatus = Array(
            repeating: false, count: workout.stepCount)
        self.statusText = ""
    }

    @MainActor
    func runNextSequence() async {
        self.isRunning = true
        if !self.isRunning {
            await runSequence()
            self.upToStep += 1
        }
        isRunning = false
    }

    @MainActor
    func runSequence() async {
        DispatchQueue.main.async {
            if self.upToStep == self.workout.stepCount - 1 {
                self.buttonText = "End"
            } else {
                self.buttonText = "Continue onto step \(self.upToStep + 2)"
            }
            self.resetMatColors()
        }
        self.resetStepStatus()
        for step in 0...upToStep {
            await displayStep(stepNum: step)
            self.stepStatus[step] = Bool.random()
            if !self.stepStatus[step] {
                resetStepStatus()
                self.statusText =
                    "Step " + String(step + 1)
                    + " incorrect starting sequence again"
                self.statusColor = Color.red
                try? await Task.sleep(nanoseconds: 500_000_000)
                await runSequence()
                return
            } else {
                self.statusText = "Step " + String(step + 1) + " correct"
                self.statusColor = Color.green
            }
        }
    }

    @MainActor
    func displayStep(stepNum: Int) async {
        guard stepNum < workout.stepCount else { return }
        
        let waitTime = Double(workout.programWaitTime[stepNum]) / 1000
        try? await Task.sleep(nanoseconds: UInt64(waitTime * 1_000_000_000))
        
        if stepNum > 0 {
            let previousStep = workout.programSteps[stepNum - 1]
            gridColors[previousStep] = .white
        }
        
        let currentStep = workout.programSteps[stepNum]
        gridColors[currentStep] = (currentStep >= 40) ? .orange : .blue
    }

    func setStep(step: Int) {
        upToStep = step
    }

    func reduceStep() {
        setStep(step: upToStep - 1)
    }
}
