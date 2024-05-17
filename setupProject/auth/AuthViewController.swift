
import UIKit

final class AuthViewController: UIViewController {
    
    private let oauth2service = OAuth2Service.shared
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    weak var delegate: AuthViewControllerDelegate?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == ShowWebViewSegueIdentifier {
                guard
                    let webViewViewController = segue.destination as? WebViewController
                else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
                webViewViewController.delegate = self
            } else {
                super.prepare(for: segue, sender: sender)
            }
        }
    }

    // MARK: - Extension


extension AuthViewController: WebViewControllerDelegate {
    func webViewViewController(_ vc: WebViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(with: code) { result in
            switch result {
            case .success(let token):
                print("Received access token: \(token)")
                self.delegate?.authViewController(self, didAuthenticateWithCode: code)
            case.failure(let error):
                print("Error fetching access token: \(error)")
            }
        }
    }
    func webViewViewControllerDidCancel(_ vc: WebViewController) {
        dismiss(animated: true)
    }
}
