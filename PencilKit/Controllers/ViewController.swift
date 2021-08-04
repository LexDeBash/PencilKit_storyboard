//
//  ViewController.swift
//  PencilKit
//
//  Created by Сергей Горбачёв on 04.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvas: Canvas!
    @IBOutlet weak var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.addTarget(
            self,
            action: #selector(sliderChangeValue),
            for: .valueChanged
        )
    }
    
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        canvas.setStrokeColor(color: sender.backgroundColor ?? .black)
        slider.tintColor = sender.backgroundColor ?? .black
        slider.thumbTintColor = sender.backgroundColor ?? .black
    }

    @IBAction func undoButtonTapped(_ sender: Any) {
        canvas.undo()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        canvas.clear()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        PhotoLibraryManager().saveImage(canvasView: canvas)
    }
    
    @objc private func sliderChangeValue() {
        canvas.setStrokeWidth(width: slider.value)
    }
}

