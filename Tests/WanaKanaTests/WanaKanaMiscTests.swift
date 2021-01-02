import XCTest
@testable import WanaKana

final class WanaKanaMiscTests: XCTestCase {
    func testStripOkurigana() {
        XCTAssertEqual(WanaKana.stripOkurigana(""), "", "sanity check--empty string")
        XCTAssertEqual(WanaKana.stripOkurigana("ふふフフ"), "ふふフフ", "basic test ふふフフ")
        XCTAssertEqual(WanaKana.stripOkurigana("abc"), "abc", "basic test abc")
        XCTAssertEqual(WanaKana.stripOkurigana("ふaふbフcフ"), "ふaふbフcフ", "basic test ふaふbフcフ")
        XCTAssertEqual(WanaKana.stripOkurigana("踏み込む"), "踏み込", "basic test 踏み込む")
        XCTAssertEqual(WanaKana.stripOkurigana("使い方"), "使い方", "basic test 使い方")
        XCTAssertEqual(WanaKana.stripOkurigana("申し申し"), "申し申", "basic test 申し申し")
        XCTAssertEqual(WanaKana.stripOkurigana("お腹"), "お腹", "basic test お腹")
        XCTAssertEqual(WanaKana.stripOkurigana("お祝い"), "お祝", "basic test お祝い")

        XCTAssertEqual(WanaKana.stripOkurigana("踏み込む", leading: true), "踏み込む", "leading test 踏み込む")
        XCTAssertEqual(WanaKana.stripOkurigana("お腹", leading: true), "腹", "leading test お腹")
        XCTAssertEqual(WanaKana.stripOkurigana("お祝い", leading: true), "祝い", "leading test お祝い")

        XCTAssertEqual(WanaKana.stripOkurigana("おはら", match: "お腹"), "おはら", "match kanji おはら")
        XCTAssertEqual(WanaKana.stripOkurigana("ふみこむ", match: "踏み込む"), "ふみこ", "match kanji ふみこむ")

        XCTAssertEqual(WanaKana.stripOkurigana("おみまい", leading: true, match: "お祝い"), "みまい", "leading match kanji おみまい")
        XCTAssertEqual(WanaKana.stripOkurigana("おはら", leading: true, match: "お腹"), "はら", "leading match kanji おはら")
}
    
    func testTokenize() {
        XCTAssertEqual(WanaKana.tokenize(""), [], "sanity check--empty string")
        XCTAssertEqual(WanaKana.tokenize("ふふ"), ["ふふ"], "basic test ふふ")
        XCTAssertEqual(WanaKana.tokenize("フフ"), ["フフ"], "basic test フフ")
        XCTAssertEqual(WanaKana.tokenize("ふふフフ"), ["ふふ", "フフ"], "basic test ふふフフ")
        XCTAssertEqual(WanaKana.tokenize("阮咸"), ["阮咸"], "basic test 阮咸")
        XCTAssertEqual(WanaKana.tokenize("感じ"), ["感", "じ"], "basic test 感じ") 
        XCTAssertEqual(WanaKana.tokenize("私は悲しい"), ["私", "は", "悲", "しい"], "basic test 私は悲しい")
        XCTAssertEqual(WanaKana.tokenize("ok لنذهب!"), ["ok"," ","لنذهب", "!"], "basic test ok لنذهب!")
        XCTAssertEqual(WanaKana.tokenize("5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！"),
                       ["5", "romaji", " ", "here", "...!?",
                        "漢字", "ひらがな", "カタ", "　",
                        "カナ", "４", "「", "ＳＨＩＯ", "」。！"], "handles mixed input")
        XCTAssertEqual(WanaKana.tokenize("5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！", compact: false),
                       ["5", "romaji", " ", "here", "...!?",
                        "漢字", "ひらがな", "カタ", "　",
                        "カナ", "４", "「", "ＳＨＩＯ", "」。！"], "compact option explicitly false")
        XCTAssertEqual(WanaKana.tokenize("5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", compact: true),
                       ["5", "romaji here", "...!?", "漢字ひらがなカタ　カナ",
                        "４「", "ＳＨＩＯ", "」。！", " ", "لنذهب"], "compact option true")


        XCTAssertEqual(WanaKana.tokenizeDetailed("5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب"),
                       [TokenDetail(type: .englishNumeral, value: "5"),
                        TokenDetail(type: .en, value: "romaji"),
                        TokenDetail(type: .space, value: " "),
                        TokenDetail(type: .en, value: "here"),
                        TokenDetail(type: .englishPunctuation, value: "...!?"),
                        TokenDetail(type: .kanji, value: "漢字"),
                        TokenDetail(type: .hiragana, value: "ひらがな"),
                        TokenDetail(type: .katakana, value: "カタ"),
                        TokenDetail(type: .space, value: "　"),
                        TokenDetail(type: .katakana, value: "カナ"),
                        TokenDetail(type: .japaneseNumeral, value: "４"),
                        TokenDetail(type: .japanesePunctuation, value: "「"),
                        TokenDetail(type: .ja, value: "ＳＨＩＯ"),
                        TokenDetail(type: .japanesePunctuation, value: "」。！"),
                        TokenDetail(type: .space, value: " "),
                        TokenDetail(type: .other, value: "لنذهب"),
                        ], "detailed")
        XCTAssertEqual(WanaKana.tokenizeDetailed("5romaji here...!?漢字ひらがなカタ　カナ４「ＳＨＩＯ」。！ لنذهب", compact: true),
                       [TokenDetail(type: .other, value: "5"),
                        TokenDetail(type: .en, value: "romaji here"),
                        TokenDetail(type: .other, value: "...!?"),
                        TokenDetail(type: .ja, value: "漢字ひらがなカタ　カナ"),
                        TokenDetail(type: .other, value: "４「"),
                        TokenDetail(type: .ja, value: "ＳＨＩＯ"),
                        TokenDetail(type: .other, value: "」。！"),
                        TokenDetail(type: .en, value: " "),
                        TokenDetail(type: .other, value: "لنذهب"),
                        ], "compact detailed")
    }

    static var allTests = [
        ("testStripOkurigana", testStripOkurigana),
        ("testTokenize", testTokenize),
        ]
}

