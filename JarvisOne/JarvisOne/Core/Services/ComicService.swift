import Foundation
import RxSwift

class ComicService {
    private let clientApi = API()
    private let bag = DisposeBag()

    func getComicDetailData(_ id: Int, completion: @escaping(Result<ComicDataContainer, Error>) -> Void) {
        getComicDetailByIdObservable(id)
            .subscribe(onNext: { comicDetailDataResponse in
                guard let comicData = comicDetailDataResponse else {
                    completion(.failure(JarvisOneError.comicNotFound(id: id)))
                    return
                }
                completion(.success(comicData))
            }, onError: { _ in
                completion(.failure(JarvisOneError.comicNotFound(id: id)))
            })
            .disposed(by: bag)
    }

    func getComicDetailByIdObservable(_ id: Int) -> Observable<ComicDataContainer?> {
        let comicDetailResponse = clientApi.makeRequest(.comicById(id))

        return comicDetailResponse
            .flatMap { data -> Observable<ComicDataContainer?> in
                do {
                    if let jsonObjectReceived = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                        let dataObj = jsonObjectReceived["data"] as? [String: Any] {
                        let data = try JSONSerialization.data(withJSONObject: dataObj, options: [])
                        let comicDetailFullData = try JSONDecoder().decode(ComicDataContainer.self, from: data)
                        return Observable.just(comicDetailFullData)
                    } else {
                        return Observable.just(nil)
                    }
                } catch {
                    return Observable.just(nil)
                }
            }
    }
}
