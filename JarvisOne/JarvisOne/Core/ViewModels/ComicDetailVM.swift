import Foundation
import RxSwift

final class ComicDetailVM: BaseVMProtocol {
    var isLoading = BehaviorSubject<Bool>(value: true)
    private var comicId: Int
    private let comicService = ComicService()
    private var currentComicIndex: Int = 0
    let comicDataContainer = BehaviorSubject<ComicDataContainer?>(value: nil)

    init(comicId: Int) {
        self.comicId = comicId
    }

    func start() {
        getComicDetailData(for: comicId)
    }

    private func getComicDetailData(for id: Int) {
        isLoading.onNext(true)
        comicService.getComicDetailData(id) { [weak self] result in
            switch result {
            case .success(let comicDataContainer):
                self?.isLoading.onNext(false)
                self?.comicDataContainer.onNext(comicDataContainer)

            case .failure(let error):
                debugPrint(error)
                self?.isLoading.onNext(false)
                JarvisOneError.comicNotFound(id: id).displayModal()
            }
        }
    }

    // I wasn't sure if the Previous/Next buttons were meant to surf the Comics within a search or trigger another Comic Search,
    // but either way, it could be done easily using currentComicIndex for the safe param
    func getCurrentComic() -> Comic? {
        guard let comicContainer = try? comicDataContainer.value() else {
            return nil
        }
        return comicContainer.results?[safe: 0]
    }

    func totalComicCount() -> Int {
        guard let comicContainer = try? comicDataContainer.value() else {
            return 0
        }
        return comicContainer.total ?? 0
    }

    func getComicFormatter() -> ComicFormatter? {
        guard let comicData = getCurrentComic() else {
            return nil
        }
        return ComicFormatter(comic: comicData)
    }

    func nextComic() {
        comicId += 1
        start()
    }

    func previousComic() {
        if comicId == 0 {
            return
        }
        comicId -= 1
        start()
    }
}
