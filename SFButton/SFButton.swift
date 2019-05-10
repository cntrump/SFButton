//
//  SFButton.swift
//  SFButton
//
//  Created by vvveiii on 2019/5/6.
//  Copyright © 2019 lvv. All rights reserved.
//

import UIKit

@objc public enum SFButtonDirection: Int {
    case row
    case rowReverse
    case column
    case columnReverse
}

public class SFButton : UIControl {
    @objc open var contentInset: UIEdgeInsets = .zero {
        didSet {
            if currentImage != nil ||
                (currentTitle != nil || currentAttributedTitle != nil) {
                invalidateLayout()
            }
        }
    }

    /// space between image and title
    @objc open var space: CGFloat = 0 {
        didSet {
            if currentImage != nil ||
                (currentTitle != nil || currentAttributedTitle != nil) {
                invalidateLayout()
            }
        }
    }

    @objc open var direction: SFButtonDirection = .row {
        didSet {
            if currentImage != nil ||
               (currentTitle != nil || currentAttributedTitle != nil) {
                invalidateLayout()
            }
        }
    }

    override public var isEnabled: Bool {
        didSet {
            updateCurrentState()
        }
    }

    override public var isHighlighted: Bool {
        didSet {
            updateCurrentState()
        }
    }

    override public var isSelected: Bool {
        didSet {
            updateCurrentState()
        }
    }

    @objc open var currentImage: UIImage? {
        get {
            let image: UIImage? = imageMap[state.rawValue]
            if image != nil {
                return image
            }

            return imageMap[UIControl.State.normal.rawValue]
        }
    }

    @objc open var currentBackgroundImage: UIImage? {
        get {
            let image: UIImage? = backgroundImageMap[state.rawValue]
            if image != nil {
                return image
            }


            return backgroundImageMap[UIControl.State.normal.rawValue]
        }
    }

    @objc open var currentTitle: String? {
        get {
            let title: String? = titleMap[state.rawValue]
            if title != nil {
                return title
            }

            return titleMap[UIControl.State.normal.rawValue]
        }
    }

    @objc open var currentTitleColor: UIColor? {
        get {
            var color: UIColor? = titleColorMap[state.rawValue]
            if color != nil {
                return color
            }

            color = titleColorMap[UIControl.State.normal.rawValue]
            if color == nil {
                color = UIColor.black
            }

            return color
        }
    }

    @objc open var currentAttributedTitle: NSAttributedString? {
        get {
            let attributedTitle: NSAttributedString? = attributedTitleMap[state.rawValue]
            if attributedTitle != nil {
                return attributedTitle
            }

            return attributedTitleMap[UIControl.State.normal.rawValue]
        }
    }

    private lazy var imageMap: Dictionary<UInt, UIImage> = Dictionary()
    private lazy var backgroundImageMap: Dictionary<UInt, UIImage> = Dictionary()
    private lazy var titleMap: Dictionary<UInt, String> = Dictionary()
    private lazy var titleColorMap: Dictionary<UInt, UIColor> = Dictionary()
    private lazy var attributedTitleMap: Dictionary<UInt, NSAttributedString> = Dictionary()

    @objc open private(set) var titleLabel: UILabel!
    @objc open private(set) var imageView: UIImageView!
    @objc open private(set) var backgroundImageView: UIImageView!

    @objc public override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundImageView = UIImageView()
        backgroundImageView.image = currentBackgroundImage
        addSubview(backgroundImageView)

        titleLabel = UILabel()
        addSubview(titleLabel)

        imageView = UIImageView()
        imageView.image = currentImage
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        var titleLabelFrame = CGRect.zero
        var imageViewFrame: CGRect = CGRect.zero
        var hasImage: Bool = false, hasTitle: Bool = false

        if currentImage != nil {
            imageView.sizeToFit()
            imageViewFrame = imageView.frame
            hasImage = true
        }

        if currentTitle != nil || currentAttributedTitle != nil {
            titleLabel.sizeToFit()
            titleLabelFrame = titleLabel.frame
            hasTitle = true
        }

        let offset = (hasImage && hasTitle ? space : 0)

        var w: CGFloat = 0
        var h: CGFloat = 0

        switch direction {
        case .row:
            w = titleLabelFrame.width + imageViewFrame.width + offset
            imageViewFrame.origin.x = bounds.midX - w * 0.5 - (contentInset.right - contentInset.left) * 0.5
            titleLabelFrame.origin.x = imageViewFrame.maxX + offset
            imageViewFrame.origin.y = bounds.midY - imageViewFrame.height * 0.5 - (contentInset.bottom - contentInset.top) * 0.5
            titleLabelFrame.origin.y = bounds.midY - titleLabelFrame.height * 0.5 - (contentInset.bottom - contentInset.top) * 0.5

        case .rowReverse:
            w = titleLabelFrame.width + imageViewFrame.width + offset
            titleLabelFrame.origin.x = bounds.midX - w * 0.5 - (contentInset.right - contentInset.left) * 0.5
            imageViewFrame.origin.x = titleLabelFrame.maxX + offset
            titleLabelFrame.origin.y = bounds.midY - titleLabelFrame.height * 0.5 - (contentInset.bottom - contentInset.top) * 0.5
            imageViewFrame.origin.y = bounds.midY - imageViewFrame.height * 0.5 - (contentInset.bottom - contentInset.top) * 0.5

        case .column:
            h = titleLabelFrame.height + imageViewFrame.height + offset
            imageViewFrame.origin.y = bounds.midY - h * 0.5 - (contentInset.bottom - contentInset.top) * 0.5
            titleLabelFrame.origin.y = imageViewFrame.maxY + offset
            imageViewFrame.origin.x = bounds.midX - imageViewFrame.width * 0.5 - (contentInset.right - contentInset.left) * 0.5
            titleLabelFrame.origin.x = bounds.midX - titleLabelFrame.width * 0.5 - (contentInset.right - contentInset.left) * 0.5

        case .columnReverse:
            h = titleLabelFrame.height + imageViewFrame.height + offset
            titleLabelFrame.origin.y = bounds.midY - h * 0.5 - (contentInset.bottom - contentInset.top) * 0.5
            imageViewFrame.origin.y = titleLabelFrame.maxY + offset
            titleLabelFrame.origin.x = bounds.midX - titleLabelFrame.width * 0.5 - (contentInset.right - contentInset.left) * 0.5
            imageViewFrame.origin.x = bounds.midX - imageViewFrame.width * 0.5 - (contentInset.right - contentInset.left) * 0.5

        default:
            return
        }

        titleLabel.frame = titleLabelFrame
        imageView.frame = imageViewFrame

        backgroundImageView.frame = bounds
    }

    public override var intrinsicContentSize: CGSize {
        get {
            var hasImage: Bool = false, hasTitle: Bool = false
            var imageViewFrame: CGRect = .zero, titleLabelFrame: CGRect = .zero

            if currentImage != nil {
                let size = imageView.sizeThatFits(CGSize(width: .max, height: .max))
                imageViewFrame = CGRect(origin: .zero, size: size)
                hasImage = true
            }

            if currentTitle != nil || currentAttributedTitle != nil {
                let size = titleLabel.sizeThatFits(CGSize(width: .max, height: .max))
                titleLabelFrame = CGRect(origin: .zero, size: size)
                hasTitle = true
            }

            let offset: CGFloat = (hasImage && hasTitle ? space : 0)
            var w: CGFloat = 0, h: CGFloat = 0

            switch direction {
            case .row, .rowReverse:
                w = titleLabelFrame.width + imageViewFrame.width + offset
                h = max(titleLabelFrame.height, imageViewFrame.height)

            case .column, .columnReverse:
                h = titleLabelFrame.height + imageViewFrame.height + offset
                w = max(titleLabelFrame.width, imageViewFrame.width)

            default:
                return .zero
            }

            return CGSize(width: w + contentInset.left + contentInset.right,
                          height: h + contentInset.top + contentInset.bottom)
        }
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        
        return intrinsicContentSize
    }

    public override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var result = super.continueTracking(touch, with: event)
        if result {
            let pt: CGPoint = touch.location(in: self)
            result = self.bounds.contains(pt)

            if (!result) {
                cancelTracking(with: event)
            }
        }

        return result
    }

    @objc(setImage:forState:)
    public func setImage(_ image: UIImage?, for state: UIControl.State) {
        imageMap[state.rawValue] = image
        imageView.image = currentImage
    }

    @objc(setBackgroundImage:forState:)
    public func setBackgroundImage(_ image: UIImage, for state: UIControl.State) {
        backgroundImageMap[state.rawValue] = image
        backgroundImageView.image = currentBackgroundImage
    }

    @objc(setTitle:forState:)
    public func setTitle(_ title: String, for state: UIControl.State) {
        attributedTitleMap.removeValue(forKey: state.rawValue)
        titleMap[state.rawValue] = title
        titleLabel.text = currentTitle
        invalidateLayout()
    }

    @objc(setTitleColor:forState:)
    public func setTitleColor(_ titleColor: UIColor, for state: UIControl.State) {
        titleColorMap[state.rawValue] = titleColor
        titleLabel.textColor = titleColor
    }

    @objc(setAttributedTitle:forState:)
    public func setAttributedTitle(_ attributedTitle: NSAttributedString, for state: UIControl.State) {
        titleMap.removeValue(forKey: state.rawValue)
        attributedTitleMap[state.rawValue] = attributedTitle
        titleLabel.attributedText = currentAttributedTitle
        invalidateLayout()
    }

    private func updateCurrentState() {
        imageView.image = currentImage
        backgroundImageView.image = currentBackgroundImage

        if let title = currentTitle {
            titleLabel.text = title
            titleLabel.textColor = currentTitleColor
        } else if let attributedTitle = currentAttributedTitle {
            titleLabel.attributedText = attributedTitle
        }

        invalidateLayout()
    }

    private func invalidateLayout() {
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
}
