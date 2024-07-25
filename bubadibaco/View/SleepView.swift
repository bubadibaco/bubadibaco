//
//  SleepView.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 25/07/24.
//

import SwiftUI

struct SleepView: View {
    var selectedAvatar: String

    var body: some View {
        NavigationView{
            ZStack {
                Image("bgRoomNight")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(selectedAvatar) is now sleeping. Good night!")
                        .font(.title)
                        .padding()
                    if selectedAvatar == "Terry" {
                        Image("dino")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: 1000)
                    } else if selectedAvatar == "Trixie" {
                        Image("unicorn")
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(maxWidth: 1000)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
