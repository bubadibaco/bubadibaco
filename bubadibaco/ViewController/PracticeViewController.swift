//
//  PracticeViewController.swift
//  bubadibaco
//
//  Created by Michael Eko on 17/07/24.
//

import UIKit
import PencilKit

class PracticeViewController: UIViewController, PKCanvasViewDelegate, CALayerDelegate,
    UIPopoverPresentationControllerDelegate, UIScribbleInteractionDelegate {
    @IBOutlet weak var backgroundCanvasView: PKCanvasView!
    @IBOutlet weak var canvasView: PKCanvasView!
    
    var delegate: PracticeViewControllerDelegate? = nil
    var objectName: String = ""
    
    var practiceScale: CGFloat = 6.0 {
        didSet {
            generateText()
        }
    }
    var animationSpeed: CGFloat = 0.5 {
        didSet {
            generateText()
        }
    }
    var difficulty: CGFloat = 7.0 {
        didSet {
            generateText()
        }
    }
    
    let textGenerator = TextGenerator()
    var incorrectStrokeCount = 0
    
    // Animation.
    static let repeatStrokeAnimationTime: TimeInterval = 4
    static let nextStrokeAnimationTime: TimeInterval = 0.5
    
    var animatingStroke: PKStroke?
    var animationMarkerLayer: CALayer!
    var animationStartMarkerLayer: CALayer!
    var animationParametricValue: CGFloat = 0
    var animationLastFrameTime = Date()
    var animationTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup an ink for drawing, and make canvas transparent.
        canvasView.tool = PKInkingTool(.pen, color: .systemBlue, width: 10)
        canvasView.backgroundColor = .clear
        canvasView.delegate = self
        
        // Create the animation layers.
        animationMarkerLayer = CALayer()
        animationMarkerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        animationMarkerLayer.backgroundColor = UIColor.red.cgColor
        animationMarkerLayer.cornerRadius = 5
        animationMarkerLayer.delegate = self
        view.layer.addSublayer(animationMarkerLayer)
        
        animationStartMarkerLayer = CALayer()
        animationStartMarkerLayer.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        animationStartMarkerLayer.borderColor = UIColor.gray.cgColor
        animationStartMarkerLayer.borderWidth = 2
        animationStartMarkerLayer.cornerRadius = 8
        animationStartMarkerLayer.delegate = self
        view.layer.addSublayer(animationStartMarkerLayer)
        
        // Ensure that practicing wins over editing the text.
        let _ = UIScribbleInteraction(delegate: self)
        
        // Generate the starting text and begin the animation.
        generateText()
        animateNextStroke()
    }
    
    // MARK: - Text generation
    
    func generateText() {
        let text = objectName.uppercased()
        backgroundCanvasView.drawing = textGenerator.synthesizeTextDrawing(text: text, practiceScale: practiceScale, lineWidth: view.bounds.width)
        stopAnimation()
        resetPractice()
    }
    
    // MARK: - Animation
    
    func animateNextStroke() {
        let nextStrokeIndex = canvasView.drawing.strokes.count
        guard nextStrokeIndex < backgroundCanvasView.drawing.strokes.count else {
            // Hide the animation markers.
            animationMarkerLayer.opacity = 0.0
            animationStartMarkerLayer.opacity = 0.0
            return
        }
        
        let strokeToAnimate = backgroundCanvasView.drawing.strokes[nextStrokeIndex]
        animatingStroke = strokeToAnimate
        animationParametricValue = 0
        animationLastFrameTime = Date()
        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60, repeats: true) { _ in self.stepAnimation() }
        
        // Setup the start marker layer.
        animationStartMarkerLayer.position = strokeToAnimate.path.interpolatedLocation(at: 0).applying(strokeToAnimate.transform)
        animationStartMarkerLayer.opacity = 1.0
    }
    
    func startAnimation(afterDelay delay: TimeInterval) {
        // Animate the next stroke again after `delay`.
        stopAnimation()
        animationTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            // Only animate the next stroke if another animation has not already started.
            if self.animatingStroke == nil {
                self.animateNextStroke()
            }
        }
    }
    
    func stopAnimation() {
        animationMarkerLayer.opacity = 0
        animatingStroke = nil
        animationTimer?.invalidate()
    }
    
    func stepAnimation() {
        guard let animatingStroke = animatingStroke, animationParametricValue < CGFloat(animatingStroke.path.count - 1) else {
            // Animate the next stroke again, in `repeatStrokeAnimationTime` seconds.
            startAnimation(afterDelay: PracticeViewController.repeatStrokeAnimationTime)
            return
        }
        
        let currentTime = Date()
        let delta = currentTime.timeIntervalSince(animationLastFrameTime)
        animationParametricValue = animatingStroke.path.parametricValue(
            animationParametricValue,
            offsetBy: .time(delta * TimeInterval(animationSpeed)))
        animationMarkerLayer.position = animatingStroke.path.interpolatedLocation(at: animationParametricValue)
            .applying(animatingStroke.transform)
        animationMarkerLayer.opacity = 1
        animationLastFrameTime = currentTime
    }

    func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if event == "position" {
            return NSNull()
        }
        return nil
    }
    
    // MARK: - Handwriting matching
    
    func resetPractice() {
        incorrectStrokeCount = 0
        canvasView.drawing = PKDrawing()
        animateNextStroke()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // On returning from the score view controller, reset to start again.
        resetPractice()
    }
    
    var isUpdatingDrawing = false
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        // Stop any animation as soon as the user begins to draw.
        stopAnimation()
        animationStartMarkerLayer.opacity = 0.0
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        // Avoid triggering the scoring, if we are programatically mutating the drawing.
        guard !isUpdatingDrawing else { return }
        
        let testDrawing = backgroundCanvasView.drawing
        let strokeIndex = canvasView.drawing.strokes.count - 1
        
        // Score the last stroke.
        guard let lastStroke = canvasView.drawing.strokes.last else { return }
        guard strokeIndex < testDrawing.strokes.count else { return }
        
        isUpdatingDrawing = true
        
        // Stroke matching.
        let threshold: CGFloat = difficulty * practiceScale
        let distance = lastStroke.discreteFrechetDistance(to: testDrawing.strokes[strokeIndex], maxThreshold: threshold)
        
        if distance < threshold {
            // Adjust the correct stroke to have a green ink.
            canvasView.drawing.strokes[strokeIndex].ink.color = .green
            
            // If the user has finished, show the final score.
            if strokeIndex + 1 >= testDrawing.strokes.count {
                markTaskDone(objectName: objectName)
                self.delegate?.drawingDone(score: getScore())
                return
            }
        } else {
            // If the stroke drawn was bad, remove it so the user can try again.
            canvasView.drawing.strokes.removeLast()
            incorrectStrokeCount += 1
        }
        
        startAnimation(afterDelay: PracticeViewController.nextStrokeAnimationTime)
        isUpdatingDrawing = false
    }
    
    var score: Double {
        let correctStrokeCount = canvasView.drawing.strokes.count
        return 1.0 / (1.0 + Double(incorrectStrokeCount) / Double(1 + correctStrokeCount))
    }
    
    private func markTaskDone(objectName: String) {
        let item = items.first { $0.name == objectName }
        if let index = tasks.firstIndex(where: { $0.name == item!.type?.name }) {
            tasks[index].isDone = true
        }
    }
    
    func getScore() -> Double {
        if !canvasView.drawing.strokes.isEmpty {
            return score
        }
        
        return 0
    }
}

protocol PracticeViewControllerDelegate {
    func drawingDone(score: Double)
}
