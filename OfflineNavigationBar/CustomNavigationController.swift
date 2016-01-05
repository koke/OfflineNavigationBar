import UIKit

class CustomNavigationController: UINavigationController {
    final class TopLayoutHelper: NSObject, UILayoutSupport {
        let offset: CGFloat
        let baseTopLayoutGuide: UILayoutSupport

        init(baseTopLayoutGuide: UILayoutSupport, offset: CGFloat) {
            self.baseTopLayoutGuide = baseTopLayoutGuide
            self.offset = offset
            super.init()
        }

        var length: CGFloat {
            return baseTopLayoutGuide.length + offset
        }

        var topAnchor: NSLayoutYAxisAnchor {
            return baseTopLayoutGuide.topAnchor
        }

        var bottomAnchor: NSLayoutYAxisAnchor {
            return baseTopLayoutGuide.bottomAnchor
        }

        var heightAnchor: NSLayoutDimension {
            return baseTopLayoutGuide.heightAnchor
        }
    }

    var message: String? = nil {
        didSet {
            messageLabel.text = message
            messageLabel.hidden = (message == nil)
        }
    }

    func setSuperTopLayoutGuide(guide: UILayoutSupport) {
        super.performSelector("setTopLayoutGuide:", withObject: guide)
    }

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 43/255, green: 172/255, blue: 218/255, alpha: 1)
        label.textColor = UIColor.whiteColor()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setSuperTopLayoutGuide(TopLayoutHelper(baseTopLayoutGuide: super.topLayoutGuide, offset: 66))
        view.addSubview(messageLabel)
        timer.fire()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navBarFrame = navigationBar.frame
        let top = CGRectGetMaxY(navBarFrame)
        var frame = navBarFrame
        frame.origin.y = top
        frame.size.height = 66

        messageLabel.frame = frame
    }

    private lazy var timer: NSTimer = {
        return NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "timerFired", userInfo: nil, repeats: true)
    }()

    deinit {
        timer.invalidate()
    }

    func timerFired() {
        if message != nil {
            message = nil
        } else {
            message = "You are offline"
        }
    }
}

