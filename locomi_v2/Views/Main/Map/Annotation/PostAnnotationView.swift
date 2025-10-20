//
//  PostAnnotationView.swift
//  locomi_v2
//
//  Created by Sogo Nishihara on 2025/10/09.
//

import MapKit

class PostAnnotationView: MKAnnotationView {

    static let reuseIdentifier = "PostAnnotation"
    static let clusteringPostIdentifier = "post"

    var delegate: PostAnnotationViewDelegate?

    var imageViewProfile: UIImageView!
    var bubbleView: UIView!
    var labelContent: UILabel!
    var labelComments: UILabel!
    var labelLikes: UILabel!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.frame = CGRect(x: 0, y: 0, width: 100, height: 80)
//        self.layer.borderWidth = 1
        self.centerOffset = CGPoint(x: 0, y: -20)
        self.backgroundColor = .clear

        setupImageViewProfile()
        setupBubbleView()
        setupLabelContent()
        setupLabelComments()
        setupLabelLikes()

        initConstraints()
    }

    func setupImageViewProfile() {
        imageViewProfile = UIImageView()

        imageViewProfile.image = UIImage(systemName: "person.fill")
        imageViewProfile.contentMode = .scaleAspectFill
        imageViewProfile.clipsToBounds = true
        imageViewProfile.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        imageViewProfile.layer.cornerRadius = 20
        imageViewProfile.layer.borderWidth = 1

        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageViewProfile)
    }
    func setupBubbleView() {
        bubbleView = UIView()

        // Add a custom speach bubble tail
        let rect = CGRect(x: 0, y: 0, width: 100, height: 40)
        let tailWidth: CGFloat = 12
        let tailHeight: CGFloat = 6
        let cornerRadius: CGFloat = 10
        let tailLayer = CAShapeLayer()
        let path = UIBezierPath()

        // Draw rounded rect
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: cornerRadius), controlPoint: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - tailHeight - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.width - cornerRadius, y: rect.height - tailHeight), controlPoint: CGPoint(x: rect.width, y: rect.height - tailHeight))
        // Tail
        path.addLine(to: CGPoint(x: rect.width/2 + tailWidth/2, y: rect.height - tailHeight))
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2 - tailWidth/2, y: rect.height - tailHeight))
        // Rect
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height - tailHeight))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.height - tailHeight - cornerRadius), controlPoint: CGPoint(x: 0, y: rect.height - tailHeight))
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), controlPoint: CGPoint(x: 0, y: 0))
        path.close()

        tailLayer.path = path.cgPath
        tailLayer.fillColor = UIColor.white.withAlphaComponent(0.9).cgColor
        tailLayer.strokeColor = UIColor.gray.cgColor
        tailLayer.lineWidth = 1
        bubbleView.layer.insertSublayer(tailLayer, at: 0)

        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bubbleView)
    }
    func setupLabelContent() {
        labelContent = UILabel()
        
        labelContent.text = "--"
        labelContent.font = UIFont.systemFont(ofSize: 10)
        labelContent.textAlignment = .center
        labelContent.numberOfLines = 1

        labelContent.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(labelContent)
    }
    func setupLabelComments() {
        labelComments = UILabel()

        labelComments.text = "⚪︎ -"
        labelComments.font = UIFont.systemFont(ofSize: 8)
        labelComments.textColor = .systemBlue
        labelComments.textAlignment = .left

        labelComments.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(labelComments)
    }
    func setupLabelLikes() {
        labelLikes = UILabel()

        labelLikes.text = "♡ -"
        labelLikes.font = UIFont.systemFont(ofSize: 8)
        labelLikes.textColor = .systemPink
        labelLikes.textAlignment = .right

        labelLikes.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(labelLikes)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            // Bubble view
            bubbleView.topAnchor.constraint(equalTo: self.topAnchor),
            bubbleView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bubbleView.widthAnchor.constraint(equalToConstant: 100),
            bubbleView.heightAnchor.constraint(equalToConstant: 40),

            // Content label inside bubble near top center
            labelContent.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5),
            labelContent.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8),
            labelContent.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8),

            // Comments label bottom left inside bubble
            labelComments.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10),
            labelComments.trailingAnchor.constraint(equalTo: bubbleView.centerXAnchor, constant: -8),

            // Likes label bottom right inside bubble
            labelLikes.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10),
            labelLikes.leadingAnchor.constraint(equalTo: bubbleView.centerXAnchor, constant: 8),

            // Profile image below bubble
            imageViewProfile.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 5),
            imageViewProfile.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 40),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 40),
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

    override var annotation: MKAnnotation? {
        willSet {
            guard let postAnnotation = newValue as? PostAnnotation else { return }
            let postWithUser = postAnnotation.postWithUser

            canShowCallout = false
            clusteringIdentifier = Self.clusteringPostIdentifier
            
            labelContent.text = postWithUser.post.content
            labelComments.text = "⚪︎ \(postWithUser.post.commentsCount)"
            labelLikes.text = "♡ \(postWithUser.post.likesCount)"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
