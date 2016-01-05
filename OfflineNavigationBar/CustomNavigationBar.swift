import UIKit

class CustomNavigationBar: UINavigationBar {
    private let messageHeightWhenVisible: CGFloat = 66

    var message: String? = nil {
        didSet {
            guard message != oldValue else { return }

            UIView.animateWithDuration(1) { [unowned self] in
                self.messageLabel.text = self.message
                self.messageLabel.hidden = (self.message == nil)
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
                self.layoutIfNeeded()
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

    func initialize() {
        layer.borderWidth = 2
//        addSubview(messageLabel)
        insertSubview(messageLabel, atIndex: 0)
    }
}
