
aFile = File.new("input.txt", "r").exists?
if aFile
   content = aFile.sysread(20)
   puts content
else
   puts "Unable to open file!"
end