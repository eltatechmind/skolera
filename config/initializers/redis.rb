uri = URI.parse('redis://redistogo:70168df5f51eacc7e16d787c912f4ae9@pearlfish.redistogo.com:9967/')
REDIS = Redis.new(:url => uri)