require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "kakutani"

cwd = File.dirname(__FILE__)
ISBN_1Q84  = IO.read(File.join(cwd, "responses", "9781446484197.json"))
LIST_NAMES = IO.read(File.join(cwd, "responses", "lists-names.json"))
TRADE_FIC  = IO.read(File.join(cwd, "responses", "trade-fiction.json"))
NO_RESULT  = IO.read(File.join(cwd, "responses", "no-results.json"))
SEARCH     = IO.read(File.join(cwd, "responses", "search.json"))

# Basic book as it appears on a bestseller list. Did not appear on the previous
# list
BOOK       = IO.read(File.join(cwd, "responses", "captivated-by-you.json"))

# Basic book as it appears on a bestseller list. Did appear on the previous list
GG_LIST    = IO.read(File.join(cwd, "responses", "gone-girl-list.json"))

# Basic book as it appears on a bestseller list. Has asterisk
FB_LIST    = IO.read(File.join(cwd, "responses", "flesh-blood-list.json"))

# Basic book as it appears on a bestseller list. Has dagger
TK_LIST    = IO.read(File.join(cwd, "responses", "thug-kitchen-list.json"))

# Basic book as it appears on a bestseller list. Has price
OUTL_LIST  = IO.read(File.join(cwd, "responses", "outliers-list.json"))
