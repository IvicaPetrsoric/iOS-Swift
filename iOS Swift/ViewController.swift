//
//  ProfileView.swift
//  Asignment1
//
//  Created by Ivica Petrsoric on 24.11.2023..
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(
                title: "Your details",
                subtitle: "Sunday, APR 9",
                iamge: Image(.test1)
            )
            .padding(.top, 12)
            .padding(.bottom, 8)
            
            ContentView2(
                userData: [
                    UserData(type: "Name", value: "Paul Hadson"),
                    UserData(type: "Dob", value: "Infinity"),
                    UserData(type: "Current weight", value: "Lightweight"),
                ]
            )
            
            Spacer()
        }
        .background(Color.black)

    }
    
}

// MARK: - Subviews -

private struct HeaderView: View {
    
    let title: String
    let subtitle: String
    let iamge: Image
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(subtitle)
                    .foregroundStyle(Color.gray)
                
                Text(title)
                    .font(.title)
                    .foregroundStyle(Color.white)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 0) {
                iamge
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
            }
        }
    }
}

private struct ContentView2: View {
    
    let userData: [UserData]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(userData, id: \.self) { data in
                HStack(spacing: 0) {
                    Text(data.type)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.white)
                    Spacer(minLength: 16)
                    Text(data.value)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color.white)
                }
            }
        }
        .padding(12)
    }
}

struct UserData: Hashable {
    let type: String
    let value: String
}


#Preview {
    ProfileView()
}
