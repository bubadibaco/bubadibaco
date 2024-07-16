//
//  ChooseAvatar.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 15/07/24.
//

import SwiftUI

struct ChooseAvatar: View {
    
    @State private var isShowingAvatar = false
    @State private var selectedAvatar: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack{
                Image("HomeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                            .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding()
                    ZStack{
                        Image("board")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 1000)
                        Text("Choose Avatar")
                            .font(.largeTitle)
                            .padding()
                            .bold()
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        VStack{
                            Button(action: {
                                isShowingAvatar = true
                                selectedAvatar = "Terry"
                            }) {
                                Text("Terry")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 100)
                                    .background(
                                        Capsule(style: .circular)
                                            .fill()
                                            .foregroundColor(.pink)
                                    )
                            }
                            Image("dino")
                        }
                        
                        VStack{
                            Button(action: {
                                isShowingAvatar = true
                                selectedAvatar = "Trixie"
                            }) {
                                Text("Trixie")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .bold()
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 100)
                                    .background(
                                        Capsule(style: .circular)
                                            .fill()
                                            .foregroundColor(.pink)
                                    )
                            }
                            Image("unicorn")
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                }
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(
                NavigationLink(
                    destination: AvatarIntro(selectedAvatar: selectedAvatar),
                    isActive: $isShowingAvatar,
                    label: { EmptyView() }
                )
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

struct ChooseAvatar_Previews: PreviewProvider {
    static var previews: some View {
        ChooseAvatar()
    }
}
