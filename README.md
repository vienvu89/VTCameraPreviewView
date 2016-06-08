# VTCameraPreviewView

[![CI Status](http://img.shields.io/travis/Vien Vu/VTCameraPreviewView.svg?style=flat)](https://travis-ci.org/Vien Vu/VTCameraPreviewView)
[![Version](https://img.shields.io/cocoapods/v/VTCameraPreviewView.svg?style=flat)](http://cocoapods.org/pods/VTCameraPreviewView)
[![License](https://img.shields.io/cocoapods/l/VTCameraPreviewView.svg?style=flat)](http://cocoapods.org/pods/VTCameraPreviewView)
[![Platform](https://img.shields.io/cocoapods/p/VTCameraPreviewView.svg?style=flat)](http://cocoapods.org/pods/VTCameraPreviewView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

VTCameraPreviewView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "VTCameraPreviewView"
```

## Usage

You can put view from xib and make class is this class. And set camera `isFront = yes or no` . Done!

Or

```swift


override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.



    self.preview = VTCameraPreviewView(isFront: true)
}



override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

     self.preview.frame = self.view.bounds
      self.view.addSubview(preiview)
}

```

And you can change camera by one line:

```swift

    self.preview.switchCamera()

```

## Author

Vien Vu

## License

VTCameraPreviewView is available under the MIT license. See the LICENSE file for more info.
