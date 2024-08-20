//
//  Workout.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 6/20/24.
//

import Foundation

struct Workout: Identifiable {
    var title: String
    let id: UUID
    //steps are dictated in sets of three integers first number is for left foot pad, second number is for right foot pad, third number is wait time in seconds at each step
    var description: String
    var programSteps: [Int]
    var programWaitTime: [Int]
    var stepCount: Int
    var assignDate: Date
    var dueDate: Date
    var estimatedTime: Int {
        return programWaitTime.reduce(0, +) / 1000
    }
    var theme: Theme

    init(
        title: String, id: UUID = UUID(), description: String,
        programSteps: [Int], programWaitTime: [Int],
        assignDate: Date, dueDate: Date, theme: Theme
    ) {
        assert(
            programSteps.count == programWaitTime.count,
            "All program arrays must have the same length")
        self.title = title
        self.id = id
        self.description = description
        self.programSteps = programSteps
        self.programWaitTime = programWaitTime
        self.stepCount = programSteps.count
        self.assignDate = assignDate
        self.dueDate = dueDate
        self.theme = theme
    }
}

extension Workout {
    static let workouts: [Workout] =
        [
            Workout(
                title: "Square Dancing",
                description:
                    "Square Dancing is a fun and social workout that can be done with anyone. It's a great way to get your heart rate up and improve your coordination.",
                programSteps: [
                    18, 33, 25, 19, 34, 12, 39, 23, 16, 28, 22, 18, 29, 11, 38,
                    21,
                ],
                programWaitTime: [
                    3000, 3000, 3000, 3000, 3000, 3000, 3000, 300, 3000, 3000,
                    3000, 3000, 3000, 3000, 3000, 300,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .pebble),

            Workout(
                title: "Slow Waltz",
                description:
                    "The Slow Waltz is a graceful and elegant dance that focuses on smooth movements and relaxation. Perfect for winding down after a long day.",
                programSteps: [10, 20, 30, 20, 10, 12, 22, 32, 22, 12],
                programWaitTime: [
                    4000, 4200, 4300, 4400, 4500, 4000, 4200, 4300, 4400, 4500,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .sand),

            Workout(
                title: "Ballroom Shuffle",
                description:
                    "The Ballroom Shuffle is a gentle dance style that emphasizes slow, deliberate movements to improve balance and coordination.",
                programSteps: [15, 25, 35, 5, 25, 17, 27, 37, 7, 27],
                programWaitTime: [
                    3500, 3700, 3900, 4100, 4300, 3500, 3700, 3900, 4100, 4300,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .ash),

            Workout(
                title: "Gentle Rumba",
                description:
                    "The Gentle Rumba focuses on soft, flowing movements and is great for improving posture and gentle aerobic activity.",
                programSteps: [8, 16, 24, 32, 39, 10, 18, 26, 34, 37],
                programWaitTime: [
                    3000, 3200, 3400, 3600, 3800, 3000, 3200, 3400, 3600, 3800,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .linen),

            Workout(
                title: "Relaxed Salsa",
                description:
                    "Relaxed Salsa offers a slower-paced version of Salsa dance, focusing on fluid movements and easing into the rhythm.",
                programSteps: [12, 24, 36, 28, 10, 14, 26, 38, 30, 12],
                programWaitTime: [
                    3200, 3400, 3600, 3800, 4000, 3200, 3400, 3600, 3800, 4000,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .driftwood),

            Workout(
                title: "Easygoing Tango",
                description:
                    "Easygoing Tango features a softer approach to the traditional Tango, perfect for relaxation and smooth, controlled movements.",
                programSteps: [14, 28, 32, 26, 30, 16, 30, 34, 28, 32],
                programWaitTime: [
                    3100, 3300, 3500, 3700, 3900, 3100, 3300, 3500, 3700, 3900,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .ivory),

            Workout(
                title: "Slow Foxtrot",
                description:
                    "The Slow Foxtrot is a dance style that emphasizes calm, flowing movements, ideal for relaxation and gentle exercise.",
                programSteps: [18, 36, 4, 22, 20, 38, 6, 24],
                programWaitTime: [
                    3400, 3600, 3800, 4000, 3400, 3600, 3800, 4000,
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .mist),

            Workout(
                title: "Beginner 1 Pattern 2",
                description:
                    "The Slow Foxtrot is a dance style that emphasizes calm, flowing movements, ideal for relaxation and gentle exercise.",
                programSteps: [37, 74, 29, 66, 21, 58, 13, 50, 5, 42],
                programWaitTime: [
                    3400, 3600, 3800, 4000, 4000, 4000, 3400, 3600, 3800, 4000],
                assignDate: Date(),
                dueDate: Date(),
                theme: .mist),
            
            Workout(
                title: "Intermediate 1 Pattern 4",
                description:
                    "The Slow Foxtrot is a dance style that emphasizes calm, flowing movements, ideal for relaxation and gentle exercise.",
                programSteps: [36, 78, 37, 74, 32, 33],
                programWaitTime: [3400, 3600, 3800, 4000, 4000, 4000],
                assignDate: Date(),
                dueDate: Date(),
                theme: .mist),

            Workout(
                title: "Advanced 1",
                description:
                    "The Slow Foxtrot is a dance style that emphasizes calm, flowing movements, ideal for relaxation and gentle exercise.",
                programSteps: [33, 78, 37, 74, 32, 79, 36, 75],
                programWaitTime: [3400, 3600, 3800, 4000, 4000, 4000, 4000, 4000],
                assignDate: Date(),
                dueDate: Date(),
                theme: .mist),
        ]
}
