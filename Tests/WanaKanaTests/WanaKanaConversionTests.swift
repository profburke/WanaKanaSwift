import XCTest
@testable import WanaKana

final class WanaKanaConversionTests: XCTestCase {
    func testToHiragana() {
        XCTAssertEqual(WanaKana.toHiragana(""), "", "sanity check--empty string")

        var options = Options(useObsoleteKana: true)
        XCTAssertEqual(WanaKana.toHiragana("IROHANIHOHETO", options: options), "いろはにほへと",
                       "Iroha line 1")
        XCTAssertEqual(WanaKana.toHiragana("CHIRINURUWO", options: options), "ちりぬるを",
                       "Iroha line 2")
        XCTAssertEqual(WanaKana.toHiragana("WAKAYOTARESO", options: options), "わかよたれそ",
                       "Iroha line 3")
        XCTAssertEqual(WanaKana.toHiragana("TSUNENARAMU", options: options), "つねならむ",
                       "Iroha line 4")
        XCTAssertEqual(WanaKana.toHiragana("UWINOOKUYAMA", options: options), "うゐのおくやま",
                       "Iroha line 5")
        XCTAssertEqual(WanaKana.toHiragana("KEFUKOETE", options: options), "けふこえて",
                       "Iroha line 6")
        XCTAssertEqual(WanaKana.toHiragana("ASAKIYUMEMISHI", options: options), "あさきゆめみし",
                       "Iroha line 7")
        XCTAssertEqual(WanaKana.toHiragana("WEHIMOSESU", options: options), "ゑひもせす",
                       "Iroha line 8")
        XCTAssertEqual(WanaKana.toHiragana("NLTU", options: options), "んっ",
                       "not in Iroha")
        
        XCTAssertEqual(WanaKana.toHiragana("wi"), "うぃ", "use obsolete false by default")
        options = Options(useObsoleteKana: false)
        XCTAssertEqual(WanaKana.toHiragana("wi", options: options), "うぃ",
                       "wi = うぃ (when useObsoleteKana is false)")
        options = Options(useObsoleteKana: true)
        XCTAssertEqual(WanaKana.toHiragana("wi", options: options), "ゐ",
                       "wi = ゐ (when useObsoleteKana is true)")
        XCTAssertEqual(WanaKana.toHiragana("we", options: options), "ゑ",
                       "we = ゑ (when useObsoleteKana is true)")
        
        XCTAssertEqual(WanaKana.toHiragana("only カナ"), "おんly かな",
                       "pass romaji false by default")
        options = Options(passRomaji: true)
        XCTAssertEqual(WanaKana.toHiragana("only カナ", options: options),
                       "only かな", "pass romaji")
        
        XCTAssertEqual(WanaKana.toHiragana("スーパー"), "すうぱあ", "converts to long vowels 1")
        XCTAssertEqual(WanaKana.toHiragana("バンゴー"), "ばんごう", "converts to long vowels 2")

        XCTAssertEqual(WanaKana.toHiragana("#22 ２２漢字、toukyou, オオサカ"),
                                     "#22 ２２漢字、とうきょう、 おおさか",
                                     "mixed input")
    }

    func testToKana() {
        XCTAssertEqual(WanaKana.toKana(""), "", "sanity check--empty string")

        XCTAssertEqual(WanaKana.toKana("onaji"), "おなじ", "lowercase transliterated to hiragana")
        XCTAssertEqual(WanaKana.toKana("buttsuuji"), "ぶっつうじ", "lowercase with double consonants and double vowels are transliterated to hiragana")
        XCTAssertEqual(WanaKana.toKana("ONAJI"), "オナジ", "uppercase transliterated to katakana")
        XCTAssertEqual(WanaKana.toKana("BUTTSUUJI"), "ブッツウジ", "uppercase with double consonants and double vowels are transliterated to hiragana")
        XCTAssertEqual(WanaKana.toKana("WaniKani"), "わにかに", "Mixed case returns hiragana (katakana only if all letters of mora are uppercased")
        XCTAssertEqual(WanaKana.toKana("ワニカニ AiUeO 鰐蟹 12345 @#$%"), "ワニカニ アいウえオ 鰐蟹 12345 @#$%", "Non-romaji will be passed through")
        XCTAssertEqual(WanaKana.toKana("座禅‘zazen’スタイル"), "座禅「ざぜん」スタイル", "handles mixed syllabaries")
        XCTAssertEqual(WanaKana.toKana("batsuge-mu"), "ばつげーむ", "will convert short to long dashes")

        XCTAssertEqual(WanaKana.toKana("n"), "ん", "w/out IME mode: solo n's are transliterated regardless of following chars - 1")
        XCTAssertEqual(WanaKana.toKana("shin"), "しん", "w/out IME mode: solo n's are transliterated regardless of following chars - 2")
        XCTAssertEqual(WanaKana.toKana("nn"), "んん", "w/out IME mode: double n's are transliterated to double ん")

        var options = Options(imeMode: .on)
        XCTAssertEqual(WanaKana.toKana("n", options: options), "n", "IME mode - 1")
        XCTAssertEqual(WanaKana.toKana("shin", options: options), "しn", "IME mode - 2")
        XCTAssertEqual(WanaKana.toKana("shinyou", options: options), "しにょう", "IME mode - 3")

        XCTAssertEqual(WanaKana.toKana("shin'you", options: options), "しんよう", "IME mode - 4")

        XCTAssertEqual(WanaKana.toKana("shin you", options: options), "しんよう", "IME mode - 5")
        XCTAssertEqual(WanaKana.toKana("nn", options: options), "ん", "IME mode: double n's are transliterated to single ん")

        XCTAssertEqual(WanaKana.toKana("wi"), "うぃ", "useObsoleteKana is false by default - 1")
        XCTAssertEqual(WanaKana.toKana("WI"), "ウィ", "useObsoleteKana is false by default - 1")
        options = Options(useObsoleteKana: true)
        XCTAssertEqual(WanaKana.toKana("wi", options: options), "ゐ",
                       "wi = ゐ (when useObsoleteKana is true)")
        XCTAssertEqual(WanaKana.toKana("we", options: options), "ゑ",
                       "we = ゑ (when useObsoleteKana is true)")
        XCTAssertEqual(WanaKana.toKana("WI", options: options), "ヰ",
                       "WI = ヰ (when useObsoleteKana is true)")
        XCTAssertEqual(WanaKana.toKana("WE", options: options), "ヱ",
                       "WE = ヱ (when useObsoleteKana is true)")
    }

    func testToKatakana() {
        XCTAssertEqual(WanaKana.toKatakana(""), "", "sanity check--empty string")
        
        var options = Options(useObsoleteKana: true)
        XCTAssertEqual(WanaKana.toKatakana("IROHANIHOHETO", options: options), "イロハニホヘト",
                       "Iroha line 1")
        XCTAssertEqual(WanaKana.toKatakana("CHIRINURUWO", options: options), "チリヌルヲ",
                       "Iroha line 2")
        XCTAssertEqual(WanaKana.toKatakana("WAKAYOTARESO", options: options), "ワカヨタレソ",
                       "Iroha line 3")
        XCTAssertEqual(WanaKana.toKatakana("TSUNENARAMU", options: options), "ツネナラム",
                       "Iroha line 4")
        XCTAssertEqual(WanaKana.toKatakana("UWINOOKUYAMA", options: options), "ウヰノオクヤマ",
                       "Iroha line 5")
        XCTAssertEqual(WanaKana.toKatakana("KEFUKOETE", options: options), "ケフコエテ",
                       "Iroha line 6")
        XCTAssertEqual(WanaKana.toKatakana("ASAKIYUMEMISHI", options: options), "アサキユメミシ",
                       "Iroha line 7")
        XCTAssertEqual(WanaKana.toKatakana("WEHIMOSESU", options: options), "ヱヒモセス",
                       "Iroha line 8")
        XCTAssertEqual(WanaKana.toKatakana("NLTU", options: options), "ンッ",
                       "not in Iroha")
        
        XCTAssertEqual(WanaKana.toKatakana("wi"), "ウィ", "use obsolete false by default")
        options = Options(useObsoleteKana: false)
        XCTAssertEqual(WanaKana.toKatakana("wi", options: options), "ウィ",
                       "wi = ウィ (when useObsoleteKana is false)")
        options = Options(useObsoleteKana: true)
        XCTAssertEqual(WanaKana.toKatakana("wi", options: options), "ヰ",
                       "wi = ヰ (when useObsoleteKana is true)")
        XCTAssertEqual(WanaKana.toKatakana("we", options: options), "ヱ",
                       "we = ヱ (when useObsoleteKana is true)")
        
        XCTAssertEqual(WanaKana.toKatakana("only カナ"), "オンly カナ",
                       "pass romaji false by default")
        options = Options(passRomaji: true)
        XCTAssertEqual(WanaKana.toKatakana("only かな", options: options),
                       "only カナ", "pass romaji")
        
        XCTAssertEqual(WanaKana.toKatakana("#22 ２２漢字、toukyou, オオサカ"),
                                     "#22 ２２漢字、トウキョウ、 オオサカ",
                                     "mixed input")
    }

    func testToRomaji() {
        XCTAssertEqual(WanaKana.toRomaji(""), "", "sanity check--empty string")

        XCTAssertEqual(WanaKana.toRomaji("ワニカニ　ガ　スゴイ　ダ"), "wanikani ga sugoi da",
                       "convert katakana to romaji")
        XCTAssertEqual(WanaKana.toRomaji("わにかに　が　すごい　だ"), "wanikani ga sugoi da",
                       "convert hiragana to romaji")
        XCTAssertEqual(WanaKana.toRomaji("ワニカニ　が　すごい　だ"), "wanikani ga sugoi da",
                       "convert mixed kana to romaji")

        let options = Options(upcaseKatakana: true)
        XCTAssertEqual(WanaKana.toRomaji("ワニカニ", options: options), "WANIKANI",
                       "use the upcaseKatakana flag to preserve casing. Works for katakana")
        XCTAssertEqual(WanaKana.toRomaji("ワニカニ　が　すごい　だ", options: options),
                       "WANIKANI ga sugoi da",
                       "use the upcaseKatakana flag to preserve casing. Works for mixed kana")

        XCTAssertEqual(WanaKana.toRomaji("ばつげーむ"), "batsuge-mu", "converts long dash 'ー' in hiragana to hyphen")
        XCTAssertEqual(WanaKana.toRomaji("一抹げーむ"), "一抹ge-mu", "doesn't confuse '一' (one kanji) for long dash 'ー'")
        XCTAssertEqual(WanaKana.toRomaji("スーパー"), "suupaa", "converts long dash 'ー' (chōonpu) in katakana to long vowel")
        XCTAssertEqual(WanaKana.toRomaji("缶コーヒー"), "缶koohii", "doesn't convert オー to 'ou' which occurs with hiragana")

        XCTAssertNotEqual(WanaKana.toRomaji("わにかにがすごいだ"), "wanikani ga sugoi da", "spaces must be manually entered")

        XCTAssertEqual(WanaKana.toRomaji("きんにくまん"), "kinnikuman", "double and single n")
        XCTAssertEqual(WanaKana.toRomaji("んんにんにんにゃんやん"), "nnninninnyan'yan", "N extravaganza")
        XCTAssertEqual(WanaKana.toRomaji("かっぱ　たった　しゅっしゅ ちゃっちゃ　やっつ"),
                       "kappa tatta shusshu chatcha yattsu",
                       "double consonants")

        XCTAssertEqual(WanaKana.toRomaji("っ"), "", "small tsu doesn't transliterate")
        XCTAssertEqual(WanaKana.toRomaji("ヶ"), "ヶ", "small kata ke doesn't transliterate")
        XCTAssertEqual(WanaKana.toRomaji("ヵ"), "ヵ", "small kata ka doesn't transliterate")
        XCTAssertEqual(WanaKana.toRomaji("ゃ"), "ya", "small ya")
        XCTAssertEqual(WanaKana.toRomaji("ゅ"), "yu", "small yu")
        XCTAssertEqual(WanaKana.toRomaji("ょ"), "yo", "small yo")
        XCTAssertEqual(WanaKana.toRomaji("ぁ"), "a", "small a")
        XCTAssertEqual(WanaKana.toRomaji("ぃ"), "i", "small i")
        XCTAssertEqual(WanaKana.toRomaji("ぅ"), "u", "small u")
        XCTAssertEqual(WanaKana.toRomaji("ぇ"), "e", "small e")
        XCTAssertEqual(WanaKana.toRomaji("ぉ"), "o", "small o")
        
        XCTAssertEqual(WanaKana.toRomaji("おんよみ"), "on'yomi", "Apostrophes in ambiguous consonant vowel combos - 1")
        XCTAssertEqual(WanaKana.toRomaji("んよ んあ んゆ"), "n'yo n'a n'yu", "Apostrophes in ambiguous consonant vowel combos - 2")
        XCTAssertEqual(WanaKana.toRomaji("シンヨ"), "shin'yo", "Apostrophes in ambiguous consonant vowel combos - 3")
    }
    
    static var allTests = [
        ("testToHiragana", testToHiragana),
        ("testToKana", testToKana),
        ("testToKatakana", testToKatakana),
        ("testToRomaji", testToRomaji),
        ]
}

