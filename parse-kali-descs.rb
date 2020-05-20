# https://mirror.fsmg.org.nz/kali/dists/kali-rolling/main/binary-amd64/Packages

require 'json'

pkg = nil

res = {}

ARGF.each_line do |l|
  if l =~ /^Package: (.*)$/
    pkg = $1
  elsif pkg != nil && l =~ /^Description: (.*)$/
    res[pkg] = $1

    pkg = nil
  end
end

puts JSON.generate(res)
