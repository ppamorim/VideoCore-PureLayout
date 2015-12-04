import UIKit
import PureLayout
import VideoCore

class ViewController: UIViewController, VCSessionDelegate {
  
  var didUpdateViews = false;
  
  let sessionStream : VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1280, height: 720), frameRate: 30, bitrate: 1000000, useInterfaceOrientation: false)

  override func loadView() {
    super.loadView()
    self.view.addSubview(sessionStream.previewView)
    self.view.setNeedsUpdateConstraints()
  }
  
  /*
  * Some coffee generated
  */
  override func viewDidLoad() {
    super.viewDidLoad()
    let delay = 2 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
      self.sessionStream.startRtmpSessionWithURL("somestream", andStreamKey: "myStream.stream")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func updateViewConstraints() {
    if !didUpdateViews {
      sessionStream.previewView.autoMatchDimension(.Width, toDimension: .Width, ofView: self.view)
      sessionStream.previewView.autoMatchDimension(.Height, toDimension: .Height, ofView: self.view)
      didUpdateViews = true
    }
    super.updateViewConstraints()
  }
  
  func connectionStatusChanged(sessionState: VCSessionState) {
    print(sessionStream.rtmpSessionState)
  }

}

