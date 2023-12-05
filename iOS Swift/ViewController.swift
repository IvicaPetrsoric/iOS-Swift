//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WrokoutsView()
        }
    }
}

struct WrokoutsView: View {
    
    @State private var workouts: [Workout] = []
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    ForEach(workouts) { _ in
                        let data = Workout(title: "test", date: "test", duration: "test", sfSymbol: "test")
                        WorkoutView(workout: data)
                    }
                    
                    Spacer()
                    
                    Button {
                        workouts.append(Workout.random())
                    } label: {
                        Text("Add new workout")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .frame(minHeight: proxy.size.height)
            }
        }
    }
}


import SwiftUI

struct Workout: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let duration: String
    let sfSymbol: String
}

struct WorkoutView: View {
    let workout: Workout

    var body: some View {
        HStack(spacing: 9) {
            Image(systemName: workout.sfSymbol)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)

            WorkoutDetailsView(workout: workout)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .background(RoundedRectangle(cornerRadius: 24).stroke(lineWidth: 1))
    }
}

private struct WorkoutDetailsView: View {
    let workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(workout.title)

            HStack(alignment: .lastTextBaseline, spacing: 0) {
                Text(workout.duration)
                    .font(.largeTitle)

                Spacer()

                Text(workout.date)
                    .font(.title3)

                Image(systemName: "chevron.right")
                    .padding(2)
            }
        }
    }
}


extension Workout {

    static func random() -> Self {
        let (title, symbol) = titlesAndSymbols.randomElement()!
        let date = randomDate()
        let duration = randomDuration()
        return Workout(title: title, date: date, duration: duration, sfSymbol: symbol)
    }
}

private extension Workout {

    // 31/2/2024 is a valid date somewhere...
    static func randomDate() -> String {
        let day: Int = .random(in: 1...31)
        let month: Int = .random(in: 1...12)
        let year: Int = .random(in: 22...24)
        return "\(day)/\(month)/\(year)"
    }

    static func randomDuration() -> String {
        let minutes: Int = .random(in: 0...59)
        let tens: Int = .random(in: 0...5)
        let ones: Int = .random(in: 0...9)
        return "\(minutes):\(tens)\(ones)"
    }

    static let titlesAndSymbols = [
        ("Playing Baseball", "baseball.fill"),
        ("Playing Basketball", "basketball.fill"),
        ("Swimming in Open Water", "figure.open.water.swim"),
        ("Hiking", "figure.hiking"),
        ("Running", "figure.run"),
        ("Mind and Body", "figure.mind.and.body"),
        ("Traditional Strength Training", "figure.strengthtraining.traditional"),
    ]
}
