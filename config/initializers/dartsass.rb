# Bootstrap 5.3 usa ancora @import.
Rails.application.config.dartsass.build_options += [ "--quiet-deps", "--silence-deprecation=import" ]
