//
//  ViewController.swift
//  VTCameraPreviewView
//
//  Created by Vien Vu on 06/08/2016.
//  Copyright (c) 2016 Vien Vu. All rights reserved.
//

import UIKit
import VTCameraPreviewView

class ViewController: UIViewController {
    
    @IBOutlet weak var preview: VTCameraPreviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeCamera))
        self.view.addGestureRecognizer(tapGesture)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeCamera() {
        self.preview.switchCamera()
    }

}

