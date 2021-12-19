$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir[File.join File.dirname(__FILE__), "..", "..", "spec", "support", "**", "*.rb"].each { |f| require f }