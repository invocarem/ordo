import Testing
@testable import PsalmService 

struct PsalmServiceTests {
    private var psalmService: PsalmService!

    // Setup (like XCTest's setUp)
    init() {
        psalmService = PsalmService.shared
    }


    @Test 
    func verify() {        
        #expect(2 == 2, "verify (intend to pass)")
    }

    // MARK: - Tests
    @Test 
    func psalmsAreLoaded() {
        let psalm1 = psalmService.getPsalmText(for: "1")        
        #expect(psalm1 != nil, "Psalm 1 should exist")
        #expect(!psalm1!.isEmpty, "Psalm 1 should not be empty")
        
    }

    @Test func getPsalmText_validKey() {
        let expectedText = "Beatus vir qui non abiit..." // Replace with real text
        let actualText = psalmService.getPsalmText(for: "1")
        #expect(actualText == expectedText)
    }

    @Test func getPsalmText_invalidKey() {
        let text = psalmService.getPsalmText(for: "999")
        #expect(text == nil, "Non-existent key should return nil")
    }

    @Test func getPsalmTexts_validKeys() {
        let keys = ["1", "2", "118Aleph"]
        let texts = psalmService.getPsalmTexts(for: keys)
        #expect(texts.count == keys.count)
        #expect(!texts.isEmpty)
    }

    @Test func getPsalmTexts_mixedValidAndInvalidKeys() {
        let keys = ["1", "999", "118Aleph"] // "999" is invalid
        let texts = psalmService.getPsalmTexts(for: keys)
        #expect(texts.count == 2, "Should skip invalid keys")
    }

    @Test func getPsalmTexts_emptyKeys() {
        let texts = psalmService.getPsalmTexts(for: [])
        #expect(texts.isEmpty)
    }
}