import UIKit
import MobileVLCKit

class ViewController: UIViewController {

    var mediaPlayer: VLCMediaPlayer?
    let videoView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVideoView()
        setupMediaPlayer()
    }

    private func setupVideoView() {
        // Thêm videoView vào view controller's view
        view.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false

        // Thiết lập tỷ lệ 16:9
        NSLayoutConstraint.activate([
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9), // 90% chiều rộng của parent view
            videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: 9.0 / 16.0) // Tỷ lệ 16:9
        ])
    }

    private func setupMediaPlayer() {
        mediaPlayer = VLCMediaPlayer()
        mediaPlayer?.drawable = videoView

        if let url = URL(string: "rtsp://admin:L2C5A6F7@172.16.1.105:554/cam/realmonitor?channel=2&subtype=0") {
            let media = VLCMedia(url: url)
            mediaPlayer?.media = media
        }

        mediaPlayer?.play()
    }
}

extension ViewController: VLCMediaPlayerDelegate{
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        guard let videoPlayer = aNotification.object as? VLCMediaPlayer else {return}
        switch videoPlayer.state{
        case .playing:
            print("VLCMediaPlayerDelegate: PLAYING")
        case .opening:
            print("VLCMediaPlayerDelegate: OPENING")
        case .error:
            print("VLCMediaPlayerDelegate: ERROR")
        case .buffering:
            print("VLCMediaPlayerDelegate: BUFFERING")
        case .stopped:
            print("VLCMediaPlayerDelegate: STOPPED")
        case .paused:
            print("VLCMediaPlayerDelegate: PAUSED")
        case .ended:
            print("VLCMediaPlayerDelegate: ENDED")
        case .esAdded:
            print("VLCMediaPlayerDelegate: ELEMENTARY STREAM ADDED")
        default:
            break
        }
    }
}
