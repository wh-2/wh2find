$LOAD_PATH.unshift(File.dirname(__FILE__))

Dir[File.join File.dirname(__FILE__), "..", "matchers", "*.rb"].each { |f| puts f; require f }