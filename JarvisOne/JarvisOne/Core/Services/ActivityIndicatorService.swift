import UIKit

struct ActivityIndicatorService {
    func createActivityIndicator(_ size: ActivityIndicatorSize = .large) -> UIImageView {
        let activityIndicator: UIImageView = UIImageView(image: .activityIndicator.resizeImage(size.rawValue, opaque: false))
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }

    func createActivityIndicatorView(_ frame: CGRect) -> UIView {
        let activityView = UIView(frame: frame)
        activityView.backgroundColor = .jvoBackground.withAlphaComponent(.jvoAlphaEighty)
        return activityView
    }

    func setupActivityIndicator(baseView: UIView, activityIndicator: UIImageView) {
        baseView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: baseView.centerYAnchor)
        ])

        activityIndicator.rotate()
    }

    func createStandaloneIndicator() -> UIView {
        let activityIndicator: UIImageView = UIImageView(image: .activityIndicator.resizeImage(.jvoSpace32, opaque: false))
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: .jvoSpace32),
            activityIndicator.heightAnchor.constraint(equalToConstant: .jvoSpace32)
        ])
        activityIndicator.rotate()
        return activityIndicator
    }
}
