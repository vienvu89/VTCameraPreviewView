//
//  VTCameraPreviewView.swift
//  Pods
//
//  Created by Vien Vu  on 6/7/16.
//
//

import UIKit
import AVFoundation


@IBDesignable open class VTCameraPreviewView: UIView {
    
    @IBInspectable var isFront: Bool = true {
        didSet {
            self.switchCamera()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate var session: AVCaptureSession!
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer!
    fileprivate var position: AVCaptureDevicePosition = .front
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isFront = true
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    convenience init (isFront: Bool) {
        self.init()
        self.isFront = isFront
        self.commonInit()
        
    }
    
    fileprivate func commonInit() {
        self.session = AVCaptureSession()
        
        if isFront {
            position = .front
        } else {
            position = .back
        }
        self.session.sessionPreset = AVCaptureSessionPreset640x480
        
        self.startInput()
        
        self.session.startRunning()
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.previewLayer.connection.videoOrientation = self.avOrientationForInterfaceOrientation(UIApplication.shared.statusBarOrientation)
        self.layer.addSublayer(self.previewLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(VTCameraPreviewView.orientationChanged(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.previewLayer.frame = self.bounds
    }
    
    fileprivate func cameraWithPosition(_ position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        
        for device in devices! {
            if (device as AnyObject).position == position {
                return device as? AVCaptureDevice
            }
        }
        return nil
    }
    
    fileprivate func startInput() {
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
    
    fileprivate func avOrientationForInterfaceOrientation(_ orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return .portrait
        }
        
    }
    
    @objc fileprivate func orientationChanged(_ notification: AnyObject) {
        self.previewLayer.connection.videoOrientation = self.avOrientationForInterfaceOrientation(UIApplication.shared.statusBarOrientation)
    }
    
    open func switchCamera() {
        session.beginConfiguration()
        
        for input in session.inputs {
            session.removeInput(input as! AVCaptureInput)
        }
        
        if position == .front {
            position = .back
        } else {
            position = .front
        }
        self.startInput()
        
        session.commitConfiguration()
        
    }

}
