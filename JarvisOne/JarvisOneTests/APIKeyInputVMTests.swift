import XCTest
@testable import JarvisOne

class APIKeyInputVMTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidAPIKey() {
        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("123abc456def")
        XCTAssertTrue(viewModel.apiKeySeemsValid())
    }

    func testInvalidAPIKey() {
        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("")
        XCTAssertFalse(viewModel.apiKeySeemsValid())
    }

    func testValidPrivateAPIKey() {
        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("123abc456def", privateKey: true)
        XCTAssertTrue(viewModel.apiKeySeemsValid(privateKey: true))
    }

    func testInvalidPrivateAPIKey() {
        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("", privateKey: true)
        XCTAssertFalse(viewModel.apiKeySeemsValid(privateKey: true))
    }

    func testSavingKeysToKeychain() {
        let expect = expectation(description: "Developer Keys Saved to Keychain")
        var result: Bool = false

        let viewModel = APIKeyInputVM()
        viewModel.setAPIKeyInput("123abc456def")
        viewModel.setAPIKeyInput("123abc456def", privateKey: true)
        viewModel.start()

        let localStorageService = LocalStorageService()
        if let storedKey = localStorageService.storedValue(for: Constants.StoredKeys.apiToken.key, in: .keychain) as? String,
            !storedKey.isEmpty,
            let storedPrivateKey = localStorageService.storedValue(for: Constants.StoredKeys.apiTokenPrivate.key, in: .keychain) as? String,
            !storedPrivateKey.isEmpty {
                result = true
                expect.fulfill()
        }

        waitForExpectations(timeout: 2.0) { error in
            XCTAssertTrue(result)
        }
    }
}
