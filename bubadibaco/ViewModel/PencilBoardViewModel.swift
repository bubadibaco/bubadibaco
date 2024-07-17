import Foundation
import PencilKit
import UIKit

class PencilBoardViewController: UIViewController, PKCanvasViewDelegate {
    var objectName: String?
    
    private let canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    let drawing = PKDrawing()
    let toolPicker = PKToolPicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.drawing = drawing
        canvasView.delegate = self
        view.addSubview(canvasView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCanvasViewFrame()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        // Draw based on objectName
        switch objectName {
        case "A":
            drawA()
        case "C":
            drawC()
        case "K":
            drawK()
        case "E":
            drawE()
        default:
            break
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateCanvasViewFrame()
        }, completion: nil)
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        // Handle drawing changes if needed
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        // Handle when the user begins using a tool if needed
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        // Handle when the user ends using a tool if needed
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        // Handle when the canvas finishes rendering if needed
    }
    
    // Method to change the color dynamically
    func changeStrokeColor(to color: UIColor) {
        let newTool = PKInkingTool(.pen, color: color, width: 10)
        canvasView.tool = newTool
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
    }
    
    // Method to draw an "A" on the canvas
    func drawA() {
        let center = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
        let height: CGFloat = min(canvasView.bounds.height, canvasView.bounds.width) * 0.7
        let width: CGFloat = height * 0.7 // Width adjusted proportionally to height
        let halfHeight = height / 2
        
        // Points for the left line of "A"
        let leftLinePoints = [
            CGPoint(x: center.x - width / 2, y: center.y + halfHeight),
            CGPoint(x: center.x, y: center.y - halfHeight)
        ]
        
        // Points for the right line of "A"
        let rightLinePoints = [
            CGPoint(x: center.x, y: center.y - halfHeight),
            CGPoint(x: center.x + width / 2, y: center.y + halfHeight)
        ]
        
        // Points for the horizontal line of "A"
        let horizontalLinePoints = [
            CGPoint(x: center.x - width / 4, y: center.y),
            CGPoint(x: center.x + width / 4, y: center.y)
        ]
        
        // Create the strokes for "A"
        let leftLineStroke = createStroke(from: leftLinePoints)
        let rightLineStroke = createStroke(from: rightLinePoints)
        let horizontalLineStroke = createStroke(from: horizontalLinePoints)
        
        // Add the strokes to the drawing
        var newDrawing = canvasView.drawing
        newDrawing.strokes.append(contentsOf: [leftLineStroke, rightLineStroke, horizontalLineStroke])
        canvasView.drawing = newDrawing
    }
    
    // Method to draw a "C" on the canvas
        func drawC() {
            let center = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
            let radius: CGFloat = min(canvasView.bounds.height, canvasView.bounds.width) * 0.3
            
            let startAngle: CGFloat = -.pi / 2
            let endAngle: CGFloat = .pi / 2
            
            // Points for the arc of "C"
            var arcPoints = [CGPoint]()
            let pointsCount = 150
            for i in 0...pointsCount {
                let angle = startAngle + (endAngle - startAngle) * CGFloat(i) / CGFloat(pointsCount)
                let point = CGPoint(x: center.x + radius * -cos(angle), y: center.y + radius * -sin(angle))
                arcPoints.append(point)
            }
            
            // Create the stroke for "C"
            let cStroke = createStroke(from: arcPoints)
            
            // Add the stroke to the drawing
            var newDrawing = canvasView.drawing
            newDrawing.strokes.append(cStroke)
            canvasView.drawing = newDrawing
        }
    
    // Method to draw a "K" on the canvas
    func drawK() {
      let center = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
      let height = min(canvasView.bounds.height, canvasView.bounds.width) * 0.6  // Adjusted height for the letter
      let width = height * 0.5  // Width based on proportional height
      let halfHeight = height / 2

      // Vertical line of "K"
      let verticalLinePoints = [
        CGPoint(x: center.x, y: center.y - halfHeight),
        CGPoint(x: center.x, y: center.y + halfHeight)
      ]
      let verticalStroke = createStroke(from: verticalLinePoints)

      // Top horizontal line of "K" (slightly adjusted position)
      let topHorizontalLinePoints = [
        CGPoint(x: center.x - 5 / 3, y: center.y - 5),
        CGPoint(x: center.x + 600 / 3, y: center.y - halfHeight)
      ]
      let topHorizontalStroke = createStroke(from: topHorizontalLinePoints)

      // Bottom horizontal line of "K" (slightly adjusted position)
      let bottomHorizontalLinePoints = [
        CGPoint(x: center.x - 5 / 3, y: center.y + 5),
        CGPoint(x: center.x + 600 / 3, y: center.y + halfHeight)
      ]
      let bottomHorizontalStroke = createStroke(from: bottomHorizontalLinePoints)

      // Add the strokes to the drawing in order
      var newDrawing = canvasView.drawing
      newDrawing.strokes.append(verticalStroke)
      newDrawing.strokes.append(topHorizontalStroke)
      newDrawing.strokes.append(bottomHorizontalStroke)
      canvasView.drawing = newDrawing
    }
    
    // Method to draw an "E" on the canvas with adjusted position and stroke width
    func drawE() {
      let center = CGPoint(x: canvasView.bounds.midX - 100, y: canvasView.bounds.midY) // Adjust X coordinate for left position
      let height = min(canvasView.bounds.height, canvasView.bounds.width) * 0.6  // Adjusted height for the letter
      let width = height * 0.5  // Width based on proportional height

      // Define desired stroke width
      let strokeWidth: CGFloat = 10.0  // Adjust this value for desired thickness

      // Vertical line of "E" (reuse code from drawK)
      let verticalLinePoints = [
        CGPoint(x: center.x, y: center.y - height / 2),
        CGPoint(x: center.x, y: center.y + height / 2)
      ]
      let verticalStroke = createStroke(from: verticalLinePoints, width: strokeWidth)

      // Top horizontal line of "E" (adjusted from top line of K)
      let topHorizontalLinePoints = [
        CGPoint(x: center.x - 5, y: center.y - height / 2),
        CGPoint(x: center.x + width, y: center.y - height / 2)
      ]
      let topHorizontalStroke = createStroke(from: topHorizontalLinePoints, width: strokeWidth)

      // Middle horizontal line of "E" (new line)
      let middleHorizontalLinePoints = [
        CGPoint(x: center.x - 5, y: center.y),
        CGPoint(x: center.x + width, y: center.y)
      ]
      let middleHorizontalStroke = createStroke(from: middleHorizontalLinePoints, width: strokeWidth)

      // Bottom horizontal line of "E" (adjusted from bottom line of K)
      let bottomHorizontalLinePoints = [
        CGPoint(x: center.x - 5, y: center.y + height / 2),
        CGPoint(x: center.x + width, y: center.y + height / 2)
      ]
      let bottomHorizontalStroke = createStroke(from: bottomHorizontalLinePoints, width: strokeWidth)

      // Add the strokes to the drawing in order
      var newDrawing = canvasView.drawing
      newDrawing.strokes.append(verticalStroke)
      newDrawing.strokes.append(topHorizontalStroke)
      newDrawing.strokes.append(middleHorizontalStroke)
      newDrawing.strokes.append(bottomHorizontalStroke)
      canvasView.drawing = newDrawing
    }

    // Helper method to create a stroke with specified width
    private func createStroke(from points: [CGPoint], width: CGFloat) -> PKStroke {
      var strokePoints = [PKStrokePoint]()
      for point in points {
        strokePoints.append(PKStrokePoint(location: point, timeOffset: 0, size: CGSize(width: width, height: width), opacity: 1, force: 1, azimuth: 0, altitude: 0))
      }
      let strokePath = PKStrokePath(controlPoints: strokePoints, creationDate: Date())
      return PKStroke(ink: PKInk(.pen, color: .gray), path: strokePath)
    }


    // Helper method to create a stroke from an array of points
    private func createStroke(from points: [CGPoint]) -> PKStroke {
        var strokePoints = [PKStrokePoint]()
        for point in points {
            strokePoints.append(PKStrokePoint(location: point, timeOffset: 0, size: CGSize(width: 5, height: 5), opacity: 1, force: 1, azimuth: 0, altitude: 0))
        }
        let strokePath = PKStrokePath(controlPoints: strokePoints, creationDate: Date())
        return PKStroke(ink: PKInk(.pen, color: .gray), path: strokePath)
    }
    
    // Update canvas view frame based on current orientation
    private func updateCanvasViewFrame() {
        canvasView.frame = view.bounds
    }
}
