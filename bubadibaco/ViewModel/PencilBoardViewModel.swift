import Foundation
import PencilKit
import UIKit

class PencilBoardViewModel: UIViewController, PKCanvasViewDelegate {
    
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
        canvasView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
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
}
