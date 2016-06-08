//
//  VTCameraPreviewView.swift
//  Pods
//
//  Created by Vien Vu  on 6/7/16.
//
//

import UIKit
import AVFoundation


@IBDesignable class VTCameraPreviewView: UIView {
    
    @IBInspectable var isFront: Bool = true {
        didSet {
            self.switchCamera()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private var session: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var position: AVCaptureDevicePosition = .Front
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isFront = true
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    convenience init (isFront: Bool) {
        self.init()
        self.isFront = isFront
        self.commonInit()
        
    }
    
    private func commonInit() {
        self.session = AVCaptureSession()
        
        if isFront {
            position = .Front
        } else {
            position = .Back
        }
        self.session.sessionPreset = AVCaptureSessionPreset640x480
        
        self.startInput()
        
        self.session.startRunning()
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.previewLayer.connection.videoOrientation = self.avOrientationForInterfaceOrientation(UIApplication.sharedApplication().statusBarOrientation)
        self.layer.addSublayer(self.previewLayer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VTCameraPreviewView.orientationChanged(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.previewLayer.frame = self.bounds
    }
    
    private func cameraWithPosition(position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        for device in devices {
            if device.position == position {
                return device as? AVCaptureDevice
            }
        }
        return nil
    }
    
    private func startInput() {
        let device = self.cameraWithPosition(position)
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
        } catch {
            print(error)
        }
    }
    
    private func avOrientationForInterfaceOrientation(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .Portrait:
            return .Portrait
        case .PortraitUpsideDown:
            return .PortraitUpsideDown
        case .LandscapeLeft:
            return .LandscapeLeft
        case .LandscapeRight:
            return .LandscapeRight
        default:
            return .Portrait
        }
        
    }
    
    @objc private func orientationChanged(notification: AnyObject) {
        self.previewLayer.connection.videoOrientation = self.avOrientationForInterfaceOrientation(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    func switchCamera() {
        session.beginConfiguration()
        
        for input in session.inputs {
            session.removeInput(input as! AVCaptureInput)
        }
        
        if position == .Front {
            position = .Back
        } else {
            position = .Front
        }
        self.startInput()
        
        session.commitConfiguration()
        
    }

}
