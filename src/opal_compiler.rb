#! -*- encoding : UTF-8 -*-
require 'opal'

# ソースを読む
filename = ARGV[0]
source = File.open(filename, "r").read

convPuts = 'def puts(*ary)
  tmp = ""
  ary.each do |a|
    tmp += a.to_s
  end
  `WScript.Echo(tmp)`
end

def print(*ary)
  tmp = ""
  ary.each do |a|
    tmp += a.to_s
  end
  `WScript.Echo(tmp)`
end
'
out_source = ""
#out_source = Opal::Builder.build('opal').to_s
#out_source += "\n"
out_source += Opal.compile(convPuts)
out_source += Opal.compile(source)

#print out_source.encode('Windows-31j')
File.open(File.basename(filename, ".*")+".js", "w") { |file| file.write out_source }

