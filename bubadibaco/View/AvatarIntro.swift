//
//  AvatarIntro.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import SwiftUI

struct AvatarIntro: View {
    var selectedAvatar: String

    var body: some View {
        ZStack {
            Image("livingroom")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Recap")
                    .font(.largeTitle)
                    .padding()
                
                if selectedAvatar == "Terry" {
                    Image("dino")
                        .resizable()
                        .scaledToFit()
                        .padding()
                } else if selectedAvatar == "Trixie" {
                    Image("unicorn")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarIntro(selectedAvatar: "Terry")
    }
}
