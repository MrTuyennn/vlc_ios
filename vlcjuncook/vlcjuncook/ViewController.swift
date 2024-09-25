import UIKit
import MobileVLCKit

class ViewController: UIViewController {
    
    var mediaPlayer: VLCMediaPlayer? // controller vlc
    let videoView = UIView() // show view stream
    let loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoView() // setup init view
        setupMediaPlayer() // setup init run link stream
        setupLoading() // setup loading view
    }
    
    
    /**INIT VIEW**/
    private func setupVideoView() {
        // Thêm videoView vào view controller's view
        view.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        // Thiết lập tỷ lệ 16:9
        NSLayoutConstraint.activate([
            videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            videoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1), // 90% chiều rộng của parent view
            videoView.heightAnchor.constraint(equalTo: videoView.widthAnchor, multiplier: 10 / 16.0) // Tỷ lệ 16:9
        ])
    }
    
    /**INIT PLAYER**/
    private func setupMediaPlayer() {
        mediaPlayer = VLCMediaPlayer()
        mediaPlayer?.drawable = videoView
        
        if let url = URL(string: "rtsp://admin:L2C5A6F7@172.16.1.105:554/cam/realmonitor?channel=2&subtype=0") {
            let media = VLCMedia(url: url)
            mediaPlayer?.media = media
        }
        
        mediaPlayer?.play()
    }
    
    /**INIT LOADING**/
    private func setupLoading(){
        // add loading to videoview
        videoView.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Căn giữa loadingIndicator trong videoView
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: videoView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: videoView.centerYAnchor)
        ])
        
        // Bắt đầu hiển thị loading khi view load
        loadingIndicator.startAnimating()
    }
}

extension ViewController: VLCMediaPlayerDelegate{
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        guard let videoPlayer = aNotification.object as? VLCMediaPlayer else {return}
        switch videoPlayer.state{
        case .playing:
            loadingIndicator.stopAnimating()
            print("VLCMediaPlayerDelegate: PLAYING")
        case .opening, .buffering:
            loadingIndicator.startAnimating()
            print("VLCMediaPlayerDelegate: OPENING")
        case .error:
            loadingIndicator.stopAnimating()
            print("VLCMediaPlayerDelegate: ERROR")
//        case .buffering:
//            print("VLCMediaPlayerDelegate: BUFFERING")
        case .stopped:
            loadingIndicator.stopAnimating()
            print("VLCMediaPlayerDelegate: STOPPED")
        case .paused:
            print("VLCMediaPlayerDelegate: PAUSED")
        case .ended:
            loadingIndicator.stopAnimating()
            print("VLCMediaPlayerDelegate: STOPPED or ENDED")
            print("VLCMediaPlayerDelegate: ENDED")
        case .esAdded:
            print("VLCMediaPlayerDelegate: ELEMENTARY STREAM ADDED")
        default:
            break
        }
    }
}
