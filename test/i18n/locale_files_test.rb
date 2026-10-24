require "test_helper"

# L'interfaccia è bilingue: ogni chiave dei file di traduzione dell'app deve esistere in italiano e in inglese.
# Le traduzioni di base (config/locales/defaults) sono escluse, perché quelle inglesi sono già in Rails.
class LocaleFilesTest < ActiveSupport::TestCase
  test "le traduzioni dell'app sono complete in tutte le lingue" do
    files = Dir[Rails.root.join("config/locales/**/*.yml")].reject { |f| f.include?("/defaults/") }
    app_keys = files.flat_map { |f| YAML.load_file(f, aliases: true).flat_map { |_, tree| flatten(tree) } }.uniq

    I18n.available_locales.each do |locale|
      missing = app_keys.reject { |key| I18n.exists?(key, locale) }
      assert_empty missing, "chiavi mancanti in #{locale}"
    end
  end

  private
    def flatten(tree, prefix = nil)
      tree.flat_map do |key, value|
        path = [ prefix, key ].compact.join(".")
        value.is_a?(Hash) && !value.key?("one") ? flatten(value, path) : [ path ]
      end
    end
end
