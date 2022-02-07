import XCTest
import RxSwift
@testable import JarvisOne

class ComicDetailVMTests: XCTestCase {
    let bag = DisposeBag()

    override func setUpWithError() throws {
        // The development team should have keys available for running tests in specified Environment
        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("PUBLIC_KEY")
        viewModel.setAPIKeyInput("PRIVATE_KEY", privateKey: true)
        viewModel.start()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidComicId() {
        let expect = expectation(description: "Valid Comic ID Fetch")
        var result: ComicDataContainer?

        let comicService = ComicService()
        comicService.getComicDetailData(65285) { fetchResult in
            switch fetchResult {
            case .success(let comicDataContainer):
                result = comicDataContainer
                expect.fulfill()

            case .failure(_):
                result = nil
                expect.fulfill()
            }
        }

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNotNil(result)
        }
    }

    func testInvalidComicId() {
        let expect = expectation(description: "Inalid Comic ID Fetch")
        var result: ComicDataContainer?

        let comicService = ComicService()
        comicService.getComicDetailData(0) { fetchResult in
            switch fetchResult {
            case .success(let comicDataContainer):
                result = comicDataContainer
                expect.fulfill()

            case .failure(_):
                result = nil
                expect.fulfill()
            }
        }

        waitForExpectations(timeout: 5.0) { error in
            XCTAssertNil(result)
        }
    }
}
