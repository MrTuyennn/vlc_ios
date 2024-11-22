

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let vlcController = Vlc()
           
           addChild(vlcController)
           vlcController.view.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(vlcController.view)
           
           NSLayoutConstraint.activate([
               vlcController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               vlcController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               vlcController.view.widthAnchor.constraint(equalToConstant: 200),
               vlcController.view.heightAnchor.constraint(equalToConstant: 150)
           ])
           
           vlcController.didMove(toParent: self)
       }
}
