//
//  WaterDropletsView.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 03/08/24.
//
import SwiftUI

struct WaterDroplet: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct WaterDropsView: View {
    @Binding var showerOn: Bool
    @State private var dropletXOffsets: [CGFloat] = []
    @State private var dropletOffsets: [CGFloat] = []
    @State private var dropletVisible: [Bool] = []
    @State private var dropletOpacity: [Double] = []
    
    let dropNum = 30
    
    var body: some View {
        ZStack {
            ForEach(0..<dropNum, id: \.self) { index in
                if dropletVisible.indices.contains(index) && dropletVisible[index] {
                    WaterDroplet()
                        .fill(Color.blue)
                        .frame(width: 10, height: 25)
                        .offset(x: dropletXOffsets[index], y: dropletOffsets[index])
                        .opacity(dropletOpacity[index])
                        .animation(
                            Animation.linear(duration: 2)
                                .repeatForever(autoreverses: false)
                                .delay(Double(index) * 0.1),
                            value: dropletOffsets[index]
                        )
                }
            }
        }
        .onAppear {
            if showerOn {
                initializeDroplets()
                animateDroplets()
            }
        }
        .onChange(of: showerOn) { newValue in
            if newValue {
                initializeDroplets()
                animateDroplets()
            }
        }
    }
    
    private func initializeDroplets() {
        dropletXOffsets = Array(repeating: 0, count: dropNum)
        dropletOffsets = Array(repeating: -145, count: dropNum)
        dropletVisible = Array(repeating: true, count: dropNum)
        dropletOpacity = Array(repeating: 0, count: dropNum)
        generateRandomOffsets()
    }
    
    private func generateRandomOffsets() {
        for i in 0..<dropNum {
            dropletXOffsets[i] = CGFloat.random(in: -2400 ... -2310)
        }
    }
    
    private func animateDroplets() {
        for i in 0..<dropNum {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false).delay(Double(i) * 0.1)) {
                dropletOffsets[i] = 350
                dropletOpacity[i] = 1
            }
        }
    }
}

