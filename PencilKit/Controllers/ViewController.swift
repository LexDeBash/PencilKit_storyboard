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

    @IBAction func undoButtonTapped() {
        canvas.undo()
    }
    
    @IBAction func clearButtonTapped() {
        canvas.clear()
    }
    
    @IBAction func saveButtonTapped() {
        PhotoLibraryManager.shared.saveImage(canvasView: canvas)
    }
    
    // Если работаешь через сториборд, то почему не сделал экшин для слайдера?
    // Это как то непоследовательно. Ты ведь все равно сделал для него аутлет, так и экшин тоже надо было
    @objc private func sliderChangeValue() {
        canvas.setStrokeWidth(width: slider.value)
    }
}

