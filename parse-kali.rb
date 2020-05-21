require 'json'

pkg = nil
res = {}

STDIN.each_line do |l|
  if l =~ /^Package: kali-tools-(.*)$/
    pkg = $1
  elsif pkg != nil && l =~ /^Depends: (.*)$/
    deps = $1.split(",").map(&:strip).filter { |x| x !~ /^kali-tools-/ }

    res[pkg] = deps

    pkg = nil
  end
end

puts JSON.generate(res)
