//
//  PostAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

class PostAnnotationView: MKAnnotationView {

    static let reuseIdentifier = "PostAnnotation"

    var delegate: PostAnnotationViewDelegate?

    internal var isExpanded = false

    var containerView: UIView!
    var imageButtonProfile: UIButton!
    var labelContent: UILabel!
    var labelLikes: UILabel!
    var badgeView: UIView!

    var expandedContainerView: UIView!
    var buttonDetail: UIButton!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.frame = CGRect(x: 0, y: 0, width: 60, height: 80)
        self.centerOffset = CGPoint(x: 0, y: -40)
        self.backgroundColor = .clear

        setupContainerView()
        setupImageViewProfile()
        setupLabelContent()
        setupLabelLikes()
        setupBadgeView()

        setupExpandedContainerView()
        setupButtonDetail()

        setupButtons()

        initConstraints()
    }

    func setupContainerView() {
        containerView = UIView()

        containerView.backgroundColor = .white
        containerView.alpha = 0.8

        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor

        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
    }
    func setupImageViewProfile() {
        imageButtonProfile = UIButton(type: .system)

        imageButtonProfile.setImage(
            UIImage(systemName: "face.smiling")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            , for: .normal)
        imageButtonProfile.contentMode = .scaleAspectFill
        imageButtonProfile.clipsToBounds = true
        imageButtonProfile.backgroundColor = .systemGray4
        imageButtonProfile.layer.cornerRadius = 18

        imageButtonProfile.isEnabled = false

        imageButtonProfile.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageButtonProfile)
    }
    func setupLabelContent() {
        labelContent = UILabel()
        
        labelContent.text = "sample text"
        labelContent.font = UIFont.systemFont(ofSize: 10)
        labelContent.textAlignment = .center
        
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelContent)
    }
    func setupLabelLikes() {
        labelLikes = UILabel()

        labelLikes.text = "10"
        labelLikes.font = UIFont.systemFont(ofSize: 8)
        labelLikes.textColor = .systemPink
        labelLikes.textAlignment = .center
        
        labelLikes.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelLikes)
    }
    func setupBadgeView() {
        badgeView = UIView()

        badgeView.backgroundColor = .systemRed

        badgeView.layer.cornerRadius = 6

        badgeView.isHidden = false

        badgeView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(badgeView)
    }
    func setupExpandedContainerView() {
        expandedContainerView = UIView()

        expandedContainerView.alpha = 0
        expandedContainerView.isHidden = true

        expandedContainerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(expandedContainerView)
    }
    func setupButtonDetail() {
        buttonDetail = UIButton(type: .system)

        buttonDetail.setImage(UIImage(systemName: "ellipsis.bubble"), for: .normal)

        buttonDetail.translatesAutoresizingMaskIntoConstraints = false
        expandedContainerView.addSubview(buttonDetail)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            imageButtonProfile.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageButtonProfile.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageButtonProfile.widthAnchor.constraint(equalToConstant: 36),
            imageButtonProfile.heightAnchor.constraint(equalToConstant: 36),

            labelContent.topAnchor.constraint(equalTo: imageButtonProfile.bottomAnchor, constant: 4),
            labelContent.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            labelContent.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),

            labelLikes.topAnchor.constraint(equalTo: labelContent.bottomAnchor, constant: 4),
            labelLikes.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            badgeView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            badgeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            badgeView.widthAnchor.constraint(equalToConstant: 12),
            badgeView.heightAnchor.constraint(equalToConstant: 12),

            expandedContainerView.topAnchor.constraint(equalTo: labelLikes.bottomAnchor, constant: 4),
            expandedContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            expandedContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            expandedContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            buttonDetail.topAnchor.constraint(equalTo: expandedContainerView.topAnchor, constant: 8),
            buttonDetail.centerXAnchor.constraint(equalTo: expandedContainerView.centerXAnchor),
        ])
    }

    override func prepareForDisplay() {
        super.prepareForDisplay()

        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        alpha = 0

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: [],
                       animations: {
            self.transform = .identity
            self.alpha = 1
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
