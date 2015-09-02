require "super_awesome_print/version"
require "awesome_print"

def sap msg
  ap "*** #{Time.now} ***", color: {string: :green}
  src = caller.first.gsub(Rails.root.to_s + '/', '')
  ap src, color: {string: :purpleish}
  ap msg
  ap '*** END ***', color: {string: :green}
end

module SuperAwesomePrint
end
