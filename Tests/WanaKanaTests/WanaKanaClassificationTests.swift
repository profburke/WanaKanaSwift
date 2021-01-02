import XCTest
@testable import WanaKana

final class WanaKanaClassificationTests: XCTestCase {
    func testIsHiragana() {
        XCTAssertFalse(WanaKana.isHiragana(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isHiragana("あ"), "あ is hiragana")
        XCTAssertTrue(WanaKana.isHiragana("ああ"), "ああ is hiragana")
        XCTAssertFalse(WanaKana.isHiragana("ア"), "ア is not hiragana")
        XCTAssertFalse(WanaKana.isHiragana("A"), "A is not hiragana")
        XCTAssertFalse(WanaKana.isHiragana("あア"), "あア is not hiragana")
        XCTAssertTrue(WanaKana.isHiragana("げーむ"), "ignores long dashes in hiragana")
    }

    func testIsJapanese() {
        XCTAssertFalse(WanaKana.isJapanese(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isJapanese("泣き虫"), "泣き虫 is Japanese")
        XCTAssertTrue(WanaKana.isJapanese("あア"), "あア is Japanese")
        XCTAssertFalse(WanaKana.isJapanese("A泣き虫"), "A泣き虫 is not Japanese")
        XCTAssertFalse(WanaKana.isJapanese("A"), "A is not Japanese")
        XCTAssertTrue(WanaKana.isJapanese("　"), "ja space is Japanese")
        XCTAssertFalse(WanaKana.isJapanese(" "), "en space is not Japanese")
        XCTAssertTrue(WanaKana.isJapanese("泣き虫。＃！〜〈〉《》〔〕［］【】（）｛｝〝〟"), "泣き虫。！〜 (w. zenkaku punctuation) is Japanese")
        XCTAssertFalse(WanaKana.isJapanese("泣き虫.!~"), "泣き虫.!~ (w. romaji punctuation) is not Japanese")
        XCTAssertTrue(WanaKana.isJapanese("０１２３４５６７８９"), "zenkaku numbers are considered neutral")
        XCTAssertFalse(WanaKana.isJapanese("0123456789"), "Latin numbers are not Japanese")
        XCTAssertTrue(WanaKana.isJapanese("ＭｅＴｏｏ"), "zenkaku latin letters are considered neutral")
        XCTAssertTrue(WanaKana.isJapanese("２０１１年"), "mixed with numbers is Japanese")
        XCTAssertTrue(WanaKana.isJapanese("ﾊﾝｶｸｶﾀｶﾅ"), "hankaku katakana is allowed")
        XCTAssertTrue(WanaKana.isJapanese("＃ＭｅＴｏｏ、これを前に「ＫＵＲＯＳＨＩＯ」は、都内で報道陣を前に水中探査ロボットの最終点検の様子を公開しました。イルカのような形をした探査ロボットは、全長３メートル、重さは３５０キロあります。《はじめに》冒頭、安倍総理大臣は、ことしが明治元年から１５０年にあたることに触れ「明治という新しい時代が育てたあまたの人材が、技術優位の欧米諸国が迫る『国難』とも呼ぶべき危機の中で、わが国が急速に近代化を遂げる原動力となった。今また、日本は少子高齢化という『国難』とも呼ぶべき危機に直面している。もう１度、あらゆる日本人にチャンスを創ることで、少子高齢化も克服できる」と呼びかけました。《働き方改革》続いて安倍総理大臣は、具体的な政策課題の最初に「働き方改革」を取り上げ、「戦後の労働基準法制定以来、７０年ぶりの大改革だ。誰もが生きがいを感じて、その能力を思う存分発揮すれば少子高齢化も克服できる」と述べました。そして、同一労働同一賃金の実現や、時間外労働の上限規制の導入、それに労働時間でなく成果で評価するとして労働時間の規制から外す「高度プロフェッショナル制度」の創設などに取り組む考えを強調しました。"), "randomly sliced nhk news text is Japanese")
        XCTAssertTrue(WanaKana.isJapanese("≪偽括弧≫", allowed: "/[≪≫]/"), "accepts optional allowed chars")
    }

    func testIsKana() {
        XCTAssertFalse(WanaKana.isKana(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isKana("あ"), "あ is kana")
        XCTAssertTrue(WanaKana.isKana("ア"), "ア is kana")
        XCTAssertTrue(WanaKana.isKana("あア"), "あア is kana")
        XCTAssertFalse(WanaKana.isKana("A"), "A is not kana")
        XCTAssertFalse(WanaKana.isKana("あAア"), "あAア is not kana")
        XCTAssertTrue(WanaKana.isKana("アーあ"), "ignores long dash in mixed kana")
    }

    func testIsKanji() {
        XCTAssertFalse(WanaKana.isKanji(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isKanji("切腹"), "切腹 is kanji")
        XCTAssertTrue(WanaKana.isKanji("刀"), "刀 is kanji")
        XCTAssertFalse(WanaKana.isKanji("🐸"), "emoji are not kanji")
        XCTAssertFalse(WanaKana.isKanji("あ"), "あ is not kanji")
        XCTAssertFalse(WanaKana.isKanji("ア"), "ア is not kanji")
        XCTAssertFalse(WanaKana.isKanji("あア"), "あア is not kanji")
        XCTAssertFalse(WanaKana.isKanji("A"), "A is not kanji")
        XCTAssertFalse(WanaKana.isKanji("あAア"), "あAア is not kanji")
        XCTAssertFalse(WanaKana.isKanji("１２隻"), "１２隻 is not kanji")
        XCTAssertFalse(WanaKana.isKanji("12隻"), "12隻 is not kanji")
        XCTAssertFalse(WanaKana.isKanji("隻。"), "隻。is not kanji")
    }

    func testIsKatakana() {
        XCTAssertFalse(WanaKana.isKatakana(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isKatakana("アア"), "アア is katakana")
        XCTAssertTrue(WanaKana.isKatakana("ア"), "ア is katakana")
        XCTAssertFalse(WanaKana.isKatakana("あ"), "あ is not katakana")
        XCTAssertFalse(WanaKana.isKatakana("A"), "A is not katakana")
        XCTAssertFalse(WanaKana.isKatakana("あア"), "あア is not katakana")
        XCTAssertTrue(WanaKana.isKatakana("ゲーム"), "ignores long dash in katakana")
    }

    func testIsMixed() {
        XCTAssertFalse(WanaKana.isMixed(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isMixed("Aア"), "Aア is mixed")
        XCTAssertTrue(WanaKana.isMixed("Aあ"), "Aあ is mixed")
        XCTAssertTrue(WanaKana.isMixed("Aあア"), "Aあア is mixed")
        XCTAssertFalse(WanaKana.isMixed("２あア"), "２あア is not mixed")
        XCTAssertTrue(WanaKana.isMixed("お腹A"), "お腹A is mixed")
        XCTAssertFalse(WanaKana.isMixed("お腹A", passKanji: false), "お腹A is not mixed when passkanji: false")
        XCTAssertFalse(WanaKana.isMixed("お腹"), "お腹 is not mixed")
        XCTAssertFalse(WanaKana.isMixed("腹"), "腹 is not mixed")
        XCTAssertFalse(WanaKana.isMixed("A"), "A is not mixed")
        XCTAssertFalse(WanaKana.isMixed("あ"), "あ is not mixed")
        XCTAssertFalse(WanaKana.isMixed("ア"), "ア is not mixed")
    }

    func testIsRomaji() {
        XCTAssertFalse(WanaKana.isRomaji(""), "sane defaults-empty string")
        XCTAssertTrue(WanaKana.isRomaji("A"), "A is romaji")
        XCTAssertTrue(WanaKana.isRomaji("xYz"), "xYz is romaji")
        XCTAssertTrue(WanaKana.isRomaji("Tōkyō and Ōsaka"), "Tōkyō and Ōsaka is romaji")
        XCTAssertFalse(WanaKana.isRomaji("あアA"), "あアA is not romaji")
        XCTAssertFalse(WanaKana.isRomaji("お願い"), "お願い is not romaji")
        XCTAssertFalse(WanaKana.isRomaji("熟成"), "熟成 is not romaji")
        XCTAssertTrue(WanaKana.isRomaji("a*b&c-d"), "passes latin punctuation")
        XCTAssertTrue(WanaKana.isRomaji("0123456789"), "passes latin numbers")
        XCTAssertFalse(WanaKana.isRomaji("a！b&cーd"), "fails zenkaku punctuation")
        XCTAssertFalse(WanaKana.isRomaji("ｈｅｌｌｏ"), "fails zenkaku latin")
        XCTAssertTrue(WanaKana.isRomaji("a！b&cーd", allowed: "/[！ー]/"), "accepts optional allowed chars")
    }

    static var allTests = [
        ("testIsHiragana", testIsHiragana),
        ("testIsJapanese", testIsJapanese),
        ("testIsKana", testIsKana),
        ("testIsKanji", testIsKanji),
        ("testIsKatakana", testIsKatakana),
        ("testIsMixed", testIsMixed),
        ("testIsRomaji", testIsRomaji),
    ]
}
