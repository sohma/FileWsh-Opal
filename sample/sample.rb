require 'opal'
require 'native'
require 'filewsh'

puts "### FileWsh Test"

puts "a.txt? : ", FileWsh.exist?("a.txt")
puts "none.txt? : ", FileWsh.exist?("none.txt")


puts "### FileWsh Original Method"
puts "aabbcc".split("bb")
puts "basename : ", FileWsh.basename('test/test.rb')
puts "dirname : ",FileWsh.dirname('C:/temp/test_dir/test_file.rb')
puts "join : ", FileWsh.join('C:', 'test', 'dir', 'test.rb')
puts "split : ",FileWsh.split('C:/test_dir/more_dir/test.rb')
puts "folder? dir: ", FileWsh.folder?("test_exist_dir")
puts "folder? file: ", FileWsh.folder?("a.txt")
puts "directory? dir: ", FileWsh.directory?("test_exist_dir")
puts "directory? file: ", FileWsh.directory?("a.txt")
puts "Dir.exists? dir: ", DirWsh.exists?("test_exist_dir")
puts "Dir.exists? file: ", DirWsh.exists?("a.txt")

puts "### mv dir name"
if DirWsh.exists?("test_dir")
  puts "test_dirをtest_dir2へリネームします"
	FileUtilWsh.mv_dir_name("test_dir", "test_dir2")
else
  puts "test_dir2をtest_dirへリネームします"
	FileUtilWsh.mv_dir_name("test_dir2", "test_dir")
end

puts "mv dir"
if DirWsh.exists?("test/A/田中")
  puts "test/A/田中ディレクトリがあります。"
  puts "test/B/へ田中ディレクトリを移動します。"
  FileUtilWsh.mv_dir("test/A/田中", "test/B/")
else
  puts "test/A/へ田中ディレクトリを移動します。"
  FileUtilWsh.mv_dir("test/B/田中", "test/A/")
end

puts "mkdir"
if DirWsh.exists?("test/D")
  puts "test/Dディレクトリがあります。削除します。"
  FileUtilWsh.rmdir("test/D")
else
  puts "test/Dディレクトリがありません。作成します。"
  FileUtilWsh.mkdir("test/D")
end

if DirWsh.exists?("test/C/鈴木")
  puts "test/C/鈴木があります。削除します。"
  FileUtilWsh.rmdir("test/C/鈴木")
else
  puts "test/C/鈴木がありません。コピーします。"
  FileUtilWsh.cp_r("test/src/鈴木","test/C/鈴木")
end

puts "### Write file"
text = "日本語がUTF-8で書き込まれるか？
改行もいけるか？"
f = FileWsh.open("test_text.txt", "w")
f.write(text)
f.write("writeを2回読んでも追加されるか？")
f.close

puts ""
puts "### Read file"
f = FileWsh.open("test_text.txt", "r")
text_r = f.read
f.close

puts "Read : ", text_r

puts ""
puts "### Write file using block"
FileWsh.open("test_text_block.txt", "w") do |fff|
  fff.write("ブロックから書いています")
  fff.write("むちゃくちゃ書いています")
end

puts "Read : ", FileWsh.open("test_text_block.txt", "r").read

puts ""
puts "### Open file mode a"
FileWsh.open("test_text_mode_a.txt", "w") do |ffw|
  ffw.write("log 1")
  ffw.write("log 2")
end

FileWsh.open("test_text_mode_a.txt", "a") do |ffa|
  ffa.write("log 3")
  ffa.write("log 4")
end

puts "Read : "
puts FileWsh.open("test_text_mode_a.txt", "r").read

puts "### Files"
puts DirWsh.glob_files("./")
puts ""
puts "### Dirs"
puts DirWsh.glob_dirs("./")
puts ""
puts "### Files and Dirs"
puts DirWsh.glob("./")


