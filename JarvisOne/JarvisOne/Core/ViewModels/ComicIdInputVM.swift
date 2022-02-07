import Foundation
import RxSwift

final class ComicIdInputVM: BaseVMProtocol {
    var isLoading = BehaviorSubject<Bool>(value: false)
    private var temporaryComicId: String = ""
    private var comicId: Int = 0

    func start() {
        isLoading.onNext(true)

        if !comicIdSeemsValid() {
            displayError()
            return
        } else {
            parseComicId()
        }

        isLoading.onNext(false)
        loadComicDetailFlow()
    }

    func setComicIdInput(_ comicId: String) {
        temporaryComicId = comicId
    }

    func comicIdSeemsValid() -> Bool {
        let digitsCharacters = CharacterSet.decimalDigits
        return CharacterSet(charactersIn: temporaryComicId).isSubset(of: digitsCharacters)
    }

    private func parseComicId() {
        let parsedId = Int(temporaryComicId) ?? 0
        if parsedId == 0 {
            displayError()
            return
        }
        comicId = parsedId
    }

    private func displayError() {
        isLoading.onNext(false)
        JarvisOneError.comicIdSeemsInvalid.displayModal()
    }

    func loadComicDetailFlow() {
        AppCoordinator.shared.presentComicDetailFlow(with: comicId)
    }
}
