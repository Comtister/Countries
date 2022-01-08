//
//  CountriesNetworkTests.swift
//  CountriesNetworkTests
//
//  Created by Oguzhan Ozturk on 8.01.2022.
//

import XCTest
@testable import Countries

class CountriesNetworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkRequest() throws{
        let sut = NetworkServiceManager.shared
        let promise = expectation(description: "Data fetch complete")
        let testRequest = CountriesRequest()
        
        sut.sendRequest(request: testRequest) { (result : Result<CountriesResponse , NetworkServiceError>) in
            switch result {
            case .success(let success):
                promise.fulfill()
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 10)
    }
    

}
