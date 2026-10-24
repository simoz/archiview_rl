require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  test "la home usa l'italiano e non imposta cookie" do
    get root_path

    assert_response :success
    assert_select "html[lang=it]"
    assert_select "h1", text: I18n.t("home.index.title", locale: :it)
    assert_select "link[rel=stylesheet][href*=application]"
    assert_nil response.headers["Set-Cookie"]
  end

  test "la home e i link conservano la lingua inglese" do
    get root_path(locale: :en)

    assert_response :success
    assert_select "html[lang=en]"
    assert_select "h1", text: I18n.t("home.index.title", locale: :en)
    assert_select "header a[href=?]", "/?locale=en", minimum: 1
    assert_select "nav a[lang=it][href=?]", "/"
    assert_equal :it, I18n.locale
    assert_nil response.headers["Set-Cookie"]
  end

  test "una lingua sconosciuta usa l'italiano" do
    get root_path(locale: "unknown")

    assert_response :success
    assert_select "html[lang=it]"
  end

  test "il controllo di disponibilita risponde" do
    get rails_health_check_path
    assert_response :success
  end
end
