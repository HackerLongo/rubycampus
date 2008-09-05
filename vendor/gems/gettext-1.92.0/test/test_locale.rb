require 'test/unit'
require 'locale'

class TestLocale < Test::Unit::TestCase
  def test_locale_object
    obj = Locale::Object.new("ja", "JP", "eucJP")
    assert_equal("ja", obj.language)
    assert_equal("JP", obj.country)
    assert_equal("eucJP", obj.charset)
    assert_equal("ja_JP", obj.to_posix)
    assert_equal("ja_JP", obj.to_str)
    assert_equal("ja-JP", obj.to_iso3066)
    assert_equal("ja-JP", obj.to_win)
    assert_equal("ja_JP", obj.to_general)
    assert_equal("ja", obj.orig_str)
    assert_equal(["ja", "JP", "eucJP", nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("ja", "JP")
    assert_equal("ja", obj.language)
    assert_equal("JP", obj.country)
    assert_equal(nil, obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("ja_JP", obj.to_posix)
    assert_equal("ja_JP", obj.to_str)
    assert_equal("ja-JP", obj.to_iso3066)
    assert_equal("ja-JP", obj.to_win)
    assert_equal("ja_JP", obj.to_general)
    assert_equal("ja", obj.orig_str)
    assert_equal(["ja", "JP", nil, nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("ja")
    assert_equal("ja", obj.language)
    assert_equal(nil, obj.country)
    assert_equal(nil, obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("ja", obj.to_posix)
    assert_equal("ja", obj.to_str)
    assert_equal("ja", obj.to_iso3066)
    assert_equal("ja", obj.to_win)
    assert_equal("ja", obj.to_general)
    assert_equal("ja", obj.orig_str)
    assert_equal(["ja", nil, nil, nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("ja_JP.eucJP", nil, "UTF-8")
    assert_equal("ja", obj.language)
    assert_equal("JP", obj.country)
    assert_equal("UTF-8", obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("ja_JP", obj.to_posix)
    assert_equal("ja_JP", obj.to_str)
    assert_equal("ja-JP", obj.to_iso3066)
    assert_equal("ja-JP", obj.to_win)
    assert_equal("ja_JP", obj.to_general)
    assert_equal("ja_JP.eucJP", obj.orig_str)
    assert_equal(["ja", "JP", "UTF-8", nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("en-US.iso8859-1", "CA")
    assert_equal("en", obj.language)
    assert_equal("CA", obj.country)
    assert_equal("iso8859-1", obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("en_CA", obj.to_posix)
    assert_equal("en_CA", obj.to_str)
    assert_equal("en-CA", obj.to_iso3066)
    assert_equal("en-CA", obj.to_win)
    assert_equal("en_CA", obj.to_general)
    assert_equal("en-US.iso8859-1", obj.orig_str)
    assert_equal(["en", "CA", "iso8859-1", nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("uz@Latn")
    assert_equal("uz", obj.language)
    assert_equal(nil, obj.country)
    assert_equal(nil, obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal("Latn", obj.modifier)
    assert_equal("uz", obj.to_posix)
    assert_equal("uz", obj.to_str)
    assert_equal("uz", obj.to_iso3066)
    assert_equal("uz", obj.to_win)
    assert_equal("uz", obj.to_general)
    assert_equal("uz@Latn", obj.orig_str)
    assert_equal(["uz", nil, nil, nil, nil, "Latn"], obj.to_a)

    obj = Locale::Object.new("zh_CN.GB2312@test")
    assert_equal("zh", obj.language)
    assert_equal("CN", obj.country)
    assert_equal("GB2312", obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal("test", obj.modifier)
    assert_equal("zh_CN", obj.to_posix)
    assert_equal("zh_CN", obj.to_str)
    assert_equal("zh-CN", obj.to_iso3066)
    assert_equal("zh-CN", obj.to_win)
    assert_equal("zh_CN", obj.to_general)
    assert_equal(["zh", "CN", "GB2312", nil, nil, "test"], obj.to_a)

    obj = Locale::Object.new("wa_BE.iso885915@euro")
    assert_equal("wa", obj.language)
    assert_equal("BE", obj.country)
    assert_equal("iso885915", obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal("euro", obj.modifier)
    assert_equal("wa_BE", obj.to_posix)
    assert_equal("wa_BE", obj.to_str)
    assert_equal("wa-BE", obj.to_iso3066)
    assert_equal("wa-BE", obj.to_win)
    assert_equal("wa_BE", obj.to_general)
    assert_equal("wa_BE.iso885915@euro", obj.orig_str)
    assert_equal(["wa", "BE", "iso885915", nil, nil, "euro"], obj.to_a)

    obj = Locale::Object.new("hu-HU_technl")
    assert_equal("hu", obj.language)
    assert_equal("HU", obj.country)
    assert_equal(nil, obj.charset)
    assert_equal(nil, obj.script)
    assert_equal("technl", obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("hu_HU", obj.to_posix)
    assert_equal("hu_HU", obj.to_str)
    assert_equal("hu-HU", obj.to_iso3066)
    assert_equal("hu-HU", obj.to_win)
    assert_equal("hu_HU", obj.to_general)
    assert_equal("hu-HU_technl", obj.orig_str)
    assert_equal(["hu", "HU", nil, nil, "technl", nil], obj.to_a)

    obj = Locale::Object.new("uz_UZ_Latn")
    assert_equal("uz", obj.language)
    assert_equal("UZ", obj.country)
    assert_equal(nil, obj.charset)
    assert_equal("Latn", obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("uz_UZ", obj.to_posix)
    assert_equal("uz_UZ", obj.to_str)
    assert_equal("uz-UZ", obj.to_iso3066)
    assert_equal("uz-UZ-Latn", obj.to_win)
    assert_equal("uz_UZ_Latn", obj.to_general)
    assert_equal("uz_UZ_Latn", obj.orig_str)
    assert_equal(["uz", "UZ", nil, "Latn", nil, nil], obj.to_a)

    obj = Locale::Object.new("zh_Hant")
    assert_equal("zh", obj.language)
    assert_equal(nil, obj.country)
    assert_equal(nil, obj.charset)
    assert_equal("Hant", obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("zh", obj.to_posix)
    assert_equal("zh", obj.to_str)
    assert_equal("zh", obj.to_iso3066)
    assert_equal("zh-Hant", obj.to_win)
    assert_equal("zh_Hant", obj.to_general)
    assert_equal("zh_Hant", obj.orig_str)
    assert_equal(["zh", nil, nil, "Hant", nil, nil], obj.to_a)

    obj = Locale::Object.new("zh_Hant_HK")
    assert_equal("zh", obj.language)
    assert_equal("HK", obj.country)
    assert_equal(nil, obj.charset)
    assert_equal("Hant", obj.script)
    assert_equal(nil, obj.variant)
    assert_equal(nil, obj.modifier)
    assert_equal("zh_HK", obj.to_posix)
    assert_equal("zh_HK", obj.to_str)
    assert_equal("zh-HK", obj.to_iso3066)
    assert_equal("zh-HK-Hant", obj.to_win)
    assert_equal("zh_HK_Hant", obj.to_general)
    assert_equal("zh_Hant_HK", obj.orig_str)
    assert_equal(["zh", "HK", nil, "Hant", nil, nil], obj.to_a)

    obj = Locale::Object.new("de_DE@collation=phonebook,currency=DDM")
    assert_equal("de", obj.language)
    assert_equal("DE", obj.country)
    assert_equal(nil, obj.charset)
    assert_equal(nil, obj.script)
    assert_equal(nil, obj.variant)
    assert_equal("collation=phonebook,currency=DDM", obj.modifier)
    assert_equal("de_DE", obj.to_posix)
    assert_equal("de_DE", obj.to_str)
    assert_equal("de-DE", obj.to_iso3066)
    assert_equal("de-DE", obj.to_win)
    assert_equal("de_DE", obj.to_general)
    assert_equal("de_DE@collation=phonebook,currency=DDM", obj.orig_str)
    assert_equal(["de", "DE", nil, nil, nil, "collation=phonebook,currency=DDM"], obj.to_a)

    obj = Locale::Object.new("C")
    assert_equal("en", obj.language)
    assert_equal("C", obj.orig_str)
    assert_equal(["en", nil, nil, nil, nil, nil], obj.to_a)

    obj = Locale::Object.new("POSIX")
    assert_equal("en", obj.language)
    assert_equal("POSIX", obj.orig_str)
    assert_equal(["en", nil, nil, nil, nil, nil], obj.to_a)

  end

  def test_locale
    loc = Locale.clear
    if /win32|cygwin|mingw/ =~ RUBY_PLATFORM
      Locale.set("ja-jp")
      assert_equal("ja_JP", Locale.get.to_str)
      assert_equal("CP932", Locale.get.charset)
      Locale.clear
      Locale.set("C")
      assert_equal("en", Locale.get.to_str)
      assert_equal("CP1252", Locale.get.charset)
      Locale.set_current("as-IN")
      assert_equal("as_IN", Locale.get.to_str)
      assert_equal("UNICODE", Locale.get.charset)
      Locale.set_current("az_AZ-Latn")
      assert_equal("az-AZ", Locale.get.to_iso3066)
      assert_equal("az-AZ-Latn", Locale.get.to_win)
      assert_equal("CP1254", Locale.get.charset)
      Locale.set_current("iu-CA-Cans")
      assert_equal("iu-CA", Locale.get.to_iso3066)
      assert_equal("iu-CA-Cans", Locale.get.to_win)
      assert_equal("UNICODE", Locale.get.charset)
    else
      assert_equal("ja_JP", Locale.get.to_str)
      assert_equal("UTF-8", Locale.codeset)

      loc = Locale.set("ja_JP")
      assert_equal("ja_JP", loc.to_str)
      assert_equal("ja_JP", Locale.get.to_str)
      assert_equal("UTF-8", Locale.codeset)

      # Confirm to set Locale::Object
      assert_equal(loc, Locale.set(loc))
    end

  end
end

