import XCTest
@testable import JarvisOne

class ComicIdInputVMTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidComicId() {
        let viewModel = ComicIdInputVM()
        viewModel.setComicIdInput("123456")
        XCTAssertTrue(viewModel.comicIdSeemsValid())
    }

    func testInvalidComicId() {
        let viewModel = ComicIdInputVM()
        viewModel.setComicIdInput("123NONNUM456")
        XCTAssertFalse(viewModel.comicIdSeemsValid())
    }
}
