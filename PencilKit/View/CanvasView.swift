//
//  CanvasView.swift
//  CanvasView
//
//  Created by Сергей Горбачёв on 04.08.2021.
//

import UIKit

class Canvas: UIView {

    private var lines = [Line]()
    private var strokeColor = UIColor.black
    private var strokeWidth: Float = 1

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { line in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            for (index, point) in line.points.enumerated() {
                if index == 0 {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        
        lastLine.points.append(point)
        lines.append(lastLine)
 
        setNeedsDisplay()
    }
    
    func setStrokeWidth(width: Float) {
        strokeWidth = width
    }
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    func undo() {
        _ = lines.popLast() // Тут точно так должно быть? Я просто не в курсе. На сколько я понимаю тут ты отменяешь последнее действие да?
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
}

