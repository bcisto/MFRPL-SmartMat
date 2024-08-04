//
//  WorkoutDisplayView.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 7/4/24.
//

import Combine
import SwiftUI

class WorkoutManager: ObservableObject {
    @Published var upToStep: Int = -1
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
            repeating: false, count: workout.programLeft.count)
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
                repeating: Color.red, count: self.workout.programLeft.count)
        }
    }

    @MainActor
    func reset() {
        resetMatColors()
        resetStepStatus()
        upToStep = -1
        buttonText = "Start"
    }

    func resetStepStatus() {
        self.stepStatus = Array(
            repeating: false, count: workout.programLeft.count)
        self.statusText=""
    }

    @MainActor
    func runNextSequence() async {
        self.isRunning = true
        if !self.isRunning {
            self.upToStep += 1
            await runSequence()
        }
        isRunning = false
    }

    @MainActor
    func runSequence() async {
        DispatchQueue.main.async {
            if self.upToStep == self.workout.programLeft.count - 1 {
                self.buttonText = "End"
            } else {
                self.buttonText = "Continue onto step \(self.upToStep + 2)"
            }
            self.resetMatColors()
        }
        self.resetStepStatus()
        for step in 0...upToStep {
            await displayStep(stepNum: step)
            self.stepStatus[step] = Int.random(in: 0...5) > 0
            if !self.stepStatus[step] {
                resetStepStatus()
                self.statusText = "Incorrect starting sequence again"
                self.statusColor = Color.red
                await runSequence()
                return
            } else {
                self.statusText = "Correct"
                self.statusColor = Color.green
            }
        }
    }

    @MainActor
    func displayStep(stepNum: Int) async {
        guard stepNum < workout.programLeft.count else { return }

        let waitTime = Double(workout.programWaitTime[stepNum]) / 1000
        try? await Task.sleep(nanoseconds: UInt64(waitTime * 1_000_000_000))

        if stepNum > 0 {
            let previousLeft = workout.programLeft[stepNum - 1]
            let previousRight = workout.programRight[stepNum - 1]
            gridColors[previousLeft] = .white
            gridColors[previousRight] = .white
        }

        let currentLeft = workout.programLeft[stepNum]
        let currentRight = workout.programRight[stepNum]
        gridColors[currentLeft] = .orange
        gridColors[currentRight] = .indigo
    }

    func setStep(step: Int) {
        upToStep = step
    }

    func reduceStep() {
        setStep(step: upToStep - 1)
    }
}
