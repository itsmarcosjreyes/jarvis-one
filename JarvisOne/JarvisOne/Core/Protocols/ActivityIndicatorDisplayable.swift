import Foundation
import UIKit

protocol ActivityIndicatorDisplayable: AnyObject {
    var activityIndicatorView: UIView? { get set }
}

extension ActivityIndicatorDisplayable where Self: UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            if let addedActivityView = self.activityIndicatorView, addedActivityView.isDescendant(of: self.view) {
                return
            }
            let service = ActivityIndicatorService()
            let activityView = service.createActivityIndicatorView(self.view.bounds)
            let activityIndicator = service.createActivityIndicator()
            service.setupActivityIndicator(baseView: activityView, activityIndicator: activityIndicator)
            self.activityIndicatorView = activityView
            activityView.tag = 989
            self.view.addSubview(activityView)
            self.view.bringSubviewToFront(activityView)
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let prevActivityView = self.view.viewWithTag(989) {
                prevActivityView.removeFromSuperview()
            }
            self.activityIndicatorView?.removeFromSuperview()
            self.activityIndicatorView = nil
        }
    }

    func createStandaloneIndicator() -> UIView {
        let service = ActivityIndicatorService()
        return service.createStandaloneIndicator()
    }
}
