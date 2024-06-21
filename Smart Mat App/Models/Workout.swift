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
    var programLeft: [Int]
    var programRight: [Int]
    var programWaitTime: [Int]
    var assignDate: Date
    var dueDate: Date
    var estimatedTime: Int {
        return programWaitTime.reduce(0, +) / 1000
    }
    var theme: Theme

    init(
        title: String, id: UUID = UUID(), description: String,
        programLeft: [Int], programRight: [Int], programWaitTime: [Int],
        assignDate: Date, dueDate: Date, theme: Theme
    ) {
        assert(programLeft.count == programRight.count && programRight.count == programWaitTime.count, "All program arrays must have the same length")
        self.title = title
        self.id = id
        self.description = description
        self.programLeft = programLeft
        self.programRight = programRight
        self.programWaitTime = programWaitTime
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
                programLeft: [18, 33, 25, 19, 34, 12, 39, 23],
                programRight: [16, 28, 22, 18, 29, 11, 38, 21],
                programWaitTime: [
                    3000, 3000, 3000, 3000, 3000, 3000, 3000, 300
                ],
                assignDate: Date(),
                dueDate: Date(),
                theme: .orange),
            Workout(
                title: "Slow Waltz",
                description:
                    "The Slow Waltz is a graceful and elegant dance that focuses on smooth movements and relaxation. Perfect for winding down after a long day.",
                programLeft: [10, 20, 30, 40, 50],
                programRight: [12, 22, 32, 42, 52],
                programWaitTime: [4000, 4200, 4300, 4400, 4500],
                assignDate: Date(),
                dueDate: Date(),
                theme: .yellow),

            Workout(
                title: "Ballroom Shuffle",
                description:
                    "The Ballroom Shuffle is a gentle dance style that emphasizes slow, deliberate movements to improve balance and coordination.",
                programLeft: [15, 25, 35, 45, 55],
                programRight: [17, 27, 37, 47, 57],
                programWaitTime: [3500, 3700, 3900, 4100, 4300],
                assignDate: Date(),
                dueDate: Date(),
                theme: .indigo),

            Workout(
                title: "Gentle Rumba",
                description:
                    "The Gentle Rumba focuses on soft, flowing movements and is great for improving posture and gentle aerobic activity.",
                programLeft: [8, 16, 24, 32, 39],
                programRight: [10, 18, 26, 34, 37],
                programWaitTime: [3000, 3200, 3400, 3600, 3800],
                assignDate: Date(),
                dueDate: Date(),
                theme: .poppy),
            Workout(
                title: "Relaxed Salsa",
                description:
                    "Relaxed Salsa offers a slower-paced version of Salsa dance, focusing on fluid movements and easing into the rhythm.",
                programLeft: [12, 24, 36, 48, 60],
                programRight: [14, 26, 38, 50, 62],
                programWaitTime: [3200, 3400, 3600, 3800, 4000],
                assignDate: Date(),
                dueDate: Date(),
                theme: .tan),

            Workout(
                title: "Easygoing Tango",
                description:
                    "Easygoing Tango features a softer approach to the traditional Tango, perfect for relaxation and smooth, controlled movements.",
                programLeft: [14, 28, 42, 56, 70],
                programRight: [16, 30, 44, 58, 72],
                programWaitTime: [3100, 3300, 3500, 3700, 3900],
                assignDate: Date(),
                dueDate: Date(),
                theme: .bubblegum),

            Workout(
                title: "Slow Foxtrot",
                description:
                    "The Slow Foxtrot is a dance style that emphasizes calm, flowing movements, ideal for relaxation and gentle exercise.",
                programLeft: [18, 36, 54, 72],
                programRight: [20, 38, 56, 74],
                programWaitTime: [3400, 3600, 3800, 4000],
                assignDate: Date(),
                dueDate: Date(),
                theme: .lavender),
        ]
}
