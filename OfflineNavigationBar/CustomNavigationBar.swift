import UIKit

class CustomNavigationBar: UINavigationBar {
    private let messageHeightWhenVisible: CGFloat = 66

    var message: String? = nil {
        didSet {
            guard message != oldValue else { return }

                self.invalidateIntrinsicContentSize()
                self.layoutIfNeeded()
            UIView.animateWithDuration(1) { [unowned self] in
                self.messageLabel.text = self.message
                self.messageLabel.hidden = (self.message == nil)
                // http://www.emdentec.com/blog/2014/2/25/hacking-uinavigationbar
                self.transform = CGAffineTransformMakeTranslation(0, -self.messageHeight)
                if self.message != nil {
                    var newFrame = self.frame
                    newFrame.size.height += self.messageHeightWhenVisible
                    self.frame = newFrame
                } else {
                    var newFrame = self.frame
                    newFrame.size.height -= self.messageHeightWhenVisible
                    self.frame = newFrame
                }
            }
        }
    }

    private var messageHeight: CGFloat {
        if message != nil {
            return messageHeightWhenVisible
        } else {
            return 0
        }
    }

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 43/255, green: 172/255, blue: 218/255, alpha: 1)
        label.textColor = UIColor.whiteColor()
        return label
    }()

    private lazy var timer: NSTimer = {
        return NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "timerFired", userInfo: nil, repeats: true)
    }()

    override func sizeThatFits(size: CGSize) -> CGSize {
        var sizeWithLabel = super.sizeThatFits(size)
        sizeWithLabel.height += messageHeight
        return sizeWithLabel
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = bounds
        frame.origin.y = frame.height
        frame.size.height = messageHeight
        messageLabel.frame = frame
        print(frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    deinit {
        timer.invalidate()
    }

    func initialize() {
//        layer.borderWidth = 2
//        addSubview(messageLabel)
        insertSubview(messageLabel, atIndex: 0)
        timer.fire()
    }

    func timerFired() {
        if message != nil {
            message = nil
        } else {
            message = "You are offline"
        }
    }
}
