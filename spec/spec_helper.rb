require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "kakutani"

cwd = File.dirname(__FILE__)
ISBN_1Q84  = IO.read(File.join(cwd, "responses", "9781446484197.json"))
LIST_NAMES = IO.read(File.join(cwd, "responses", "lists-names.json"))
TRADE_FIC  = IO.read(File.join(cwd, "responses", "trade-fiction.json"))
NO_RESULT  = IO.read(File.join(cwd, "responses", "no-results.json"))
