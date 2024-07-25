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
                Label(
                    "\(workout.assignDate.formatted())", systemImage: "calendar"
                )
                Spacer()
                Label(
                    "\(workout.dueDate.formatted())",
                    systemImage: "calendar.circle")
                Image(systemName: "clock")
                    .padding(.trailing, 4)
                Text("\(workout.estimatedTime) secs")
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.bottom, 5)
            Spacer()
        }
        .padding()
        .cornerRadius(40)
        .shadow(radius: 5)
    }
}

struct WorkoutListView: View {
    var workouts: [Workout]

    var body: some View {
        ZStack {
            Color(red: 0.678, green: 0.847, blue: 0.902)
                .edgesIgnoringSafeArea(.all)
                .ignoresSafeArea()

            NavigationStack {
                List(workouts) { workout in
                    NavigationLink(
                        destination: WorkoutDisplayView(workout: workout)
                    ) {
                        WorkoutCardView(workout: workout)
                            .padding([.top, .horizontal])
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(workout.theme.mainColor)
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
            }
        }
    }
    func refreshWorkouts() {
        //TODO: implement get request off server
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
