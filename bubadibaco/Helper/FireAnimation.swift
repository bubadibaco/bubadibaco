//
//  FireAnimation.swift
//  bubadibaco
//
//  Created by Pelangi Masita Wati on 05/08/24.
//

import SwiftUI
import UIKit

struct FireAnimationView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let fireLayer = createFireLayer()
        fireLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.layer.addSublayer(fireLayer)
        
        print("FireAnimationView created")

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }

    private func createFireLayer() -> CAEmitterLayer {
        let fireEmitter = CAEmitterLayer()
        fireEmitter.emitterPosition = CGPoint(x: 50, y: 50)
        fireEmitter.emitterSize = CGSize(width: 20, height: 20)
        fireEmitter.emitterShape = .point

        let fireCell = CAEmitterCell()
        fireCell.birthRate = 300
        fireCell.lifetime = 1.5
        fireCell.lifetimeRange = 0.5
        fireCell.color = UIColor.red.cgColor
        fireCell.contents = createParticleImage().cgImage
        fireCell.velocity = 60
        fireCell.velocityRange = 20
        fireCell.emissionRange = .pi * 2
        fireCell.scale = 0.6
        fireCell.scaleRange = 0.2
        fireCell.alphaSpeed = -0.3
        fireCell.yAcceleration = -50

        fireEmitter.emitterCells = [fireCell]
        
        return fireEmitter
    }

    private func createParticleImage() -> UIImage {
        let size = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        
        let colors = [UIColor.orange.cgColor, UIColor.red.cgColor]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0, 1])!
        
        context.drawRadialGradient(
            gradient,
            startCenter: CGPoint(x: size.width / 2, y: size.height / 2),
            startRadius: 0,
            endCenter: CGPoint(x: size.width / 2, y: size.height / 2),
            endRadius: size.width / 2,
            options: .drawsBeforeStartLocation
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
}
