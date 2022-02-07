import XCTest

class APIKeyInputVCUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyKeys() {
        let app = XCUIApplication()
        app.launch()

        let publicKeyInputField = app.textFields["Public Key"]
        publicKeyInputField.tap()

        let doneButton = app.buttons["Done"]
        doneButton.tap()
        doneButton.tap()

        let proceedButton = app.buttons["Proceed"]
        proceedButton.tap()

        let errorDialogGotItButton = app.buttons["Got it"]
        XCTAssertTrue(errorDialogGotItButton.isHittable)
    }

    func testEnteredKeys() {
        let app = XCUIApplication()
        app.launch()

        let publicKeyInputField = app.textFields["Public Key"]
        publicKeyInputField.tap()
        let qKey = app.keys["Q"]
        let wKey = app.keys["w"]
        let eKey = app.keys["e"]
        let rKey = app.keys["r"]
        let tKey = app.keys["t"]
        let yKey = app.keys["y"]
        qKey.tap()
        wKey.tap()
        eKey.tap()
        rKey.tap()
        tKey.tap()
        yKey.tap()

        let privateKeyInputField = app.textFields["Private Key"]
        privateKeyInputField.tap()
        qKey.tap()
        wKey.tap()
        eKey.tap()
        rKey.tap()
        tKey.tap()
        yKey.tap()

        let doneButton = app.buttons["Done"]
        doneButton.tap()

        let proceedButton = app.buttons["Proceed"]
        proceedButton.tap()

        let searchButton = app.buttons["Search"]
        XCTAssertTrue(searchButton.isHittable)
    }
}
