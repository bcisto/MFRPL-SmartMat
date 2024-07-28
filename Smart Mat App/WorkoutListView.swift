//
//  WorkoutCardView.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 6/25/24.
//

import SwiftUI

struct WorkoutCardView: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.title)
                .font(.headline)
                .fontWeight(.heavy)
            Spacer()
            Text("\(workout.description)")
                .font(.subheadline)
            Spacer()
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text("\(workout.assignDate.formatted())")
                Spacer()
                Image(systemName: "calendar.circle")
                    .foregroundColor(.blue)
                Text("\(workout.dueDate.formatted())")
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                    .padding(.trailing, 4)
                Text("\(workout.estimatedTime) secs")
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.bottom, 5)
            Spacer()
        }
        .padding()
        .background(workout.theme.mainColor)
        .cornerRadius(40)
        .shadow(radius: 5)
    }
}

struct WorkoutListView: View {
    var workouts: [Workout]

    @State private var showingAlert = false
    @State private var proceedToDisplay = false
    @State private var selectedWorkout: Workout?
    @State private var navigateToWorkoutDetail: Bool? = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.9, green: 0.9, blue: 0.9)
                    .ignoresSafeArea()

                VStack {
                    List(workouts) { workout in
                        Button(action: {
                            selectedWorkout = workout
                            showingAlert = true
                        }) {
                            WorkoutCardView(workout: workout)
                                .padding([.top, .horizontal])
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(
                            Color(red: 0.95, green: 0.95, blue: 0.95)
                        )
                        .foregroundColor(workout.theme.accentColor)
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                Button(action: {
                    refreshWorkouts()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                .accessibilityLabel("Reload Workouts")
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Confirm Selection"),
                    message: Text(
                        "Do you want to select \(selectedWorkout?.title ?? "this workout")?"
                    ),
                    primaryButton: .default(Text("OK")) {
                        if let workout = selectedWorkout {
                            showingAlert=false
                        }
                    },
                    secondaryButton: .cancel {
                        showingAlert = false
                        selectedWorkout = nil
                    }
                )
            }
            .navigationDestination(
                isPresented: Binding<Bool>(
                    get: { selectedWorkout != nil },
                    set: { if !$0 { selectedWorkout = nil } }
                )
            ) {
                if let workout = selectedWorkout {
                    WorkoutDisplayView(workout: workout)
                }
            }
        }
        .ignoresSafeArea()
    }

    func refreshWorkouts() {
        // TODO: implement get request off server
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    @State static var workouts: [Workout] = Workout.workouts
    static var previews: some View {
        WorkoutListView(workouts: workouts)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
