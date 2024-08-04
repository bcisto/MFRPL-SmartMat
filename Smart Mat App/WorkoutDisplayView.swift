//
//  WorkoutDisplayView.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 7/15/24.
//
import SwiftUI

struct GridBlock: View {
    @Binding var color: Color

    var body: some View {
        Rectangle()
            .fill(color)
            .border(Color.gray, width: 1)
    }
}


struct GridContainer: View {
    @ObservedObject var manager: WorkoutManager
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        let blockWidth = (width - 6) / 4
        let blockHeight = (height - 90) / 10

        VStack(spacing: 2) {
            ForEach(0..<10, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<4, id: \.self) { column in
                        GridBlock(color: $manager.gridColors[row*4+column])
                            .frame(width: blockWidth, height: blockHeight)
                    }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct WorkoutDisplayView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var manager: WorkoutManager
    
    init(workout: Workout) {
        _manager = ObservedObject(wrappedValue: WorkoutManager(workout: workout))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(manager.workout.title)
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding([.leading, .top])
                Spacer()
                Button(action: {
                    Task {
                        manager.reset()
                    }
                }) {
                    Label("Restart", systemImage: "arrow.clockwise")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding([.trailing, .bottom])
            }
            
            Spacer(minLength: 30)
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    
                    GridContainer(manager: manager, width: geometry.size.width, height: geometry.size.height)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            Task {
                                manager.resetMatColors()
                                await manager.runSequence()
                            }
                        }) {
                            Label("Redo", systemImage: "arrow.clockwise")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding([.trailing, .bottom])
                        
                        Spacer()
                        
                        Text(manager.statusText)
                            .fontWeight(.heavy)
                            .padding()
                            .foregroundColor(manager.statusColor)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                if manager.buttonText == "End" && !manager.isRunning {
                                    presentationMode.wrappedValue.dismiss()
                                    manager.reset()
                                } else {
                                    if !manager.isRunning {
                                        await manager.runNextSequence()
                                    }
                                }
                            }
                        }) {
                            Text(manager.buttonText)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding([.trailing, .bottom])
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(manager.workout.theme.mainColor)
        .onDisappear(perform: onDismiss)
    }
    
    func onDismiss() {
        if manager.buttonText == "End" {
            presentationMode.wrappedValue.dismiss()
            manager.reset()
        } else {
            manager.resetMatColors()
            manager.reduceStep()
        }
    }
}

struct WorkoutDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDisplayView(workout: Workout.workouts[0])
    }
}
