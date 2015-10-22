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
  puts "test_dir��test_dir2�փ��l�[�����܂�"
	FileUtilWsh.mv_dir_name("test_dir", "test_dir2")
else
  puts "test_dir2��test_dir�փ��l�[�����܂�"
	FileUtilWsh.mv_dir_name("test_dir2", "test_dir")
end

puts "mv dir"
if DirWsh.exists?("test/A/�c��")
  puts "test/A/�c���f�B���N�g��������܂��B"
  puts "test/B/�֓c���f�B���N�g�����ړ����܂��B"
  FileUtilWsh.mv_dir("test/A/�c��", "test/B/")
else
  puts "test/A/�֓c���f�B���N�g�����ړ����܂��B"
  FileUtilWsh.mv_dir("test/B/�c��", "test/A/")
end

puts "mkdir"
if DirWsh.exists?("test/D")
  puts "test/D�f�B���N�g��������܂��B�폜���܂��B"
  FileUtilWsh.rmdir("test/D")
else
  puts "test/D�f�B���N�g��������܂���B�쐬���܂��B"
  FileUtilWsh.mkdir("test/D")
end

if DirWsh.exists?("test/C/���")
  puts "test/C/��؂�����܂��B�폜���܂��B"
  FileUtilWsh.rmdir("test/C/���")
else
  puts "test/C/��؂�����܂���B�R�s�[���܂��B"
  FileUtilWsh.cp_r("test/src/���","test/C/���")
end

puts "### Write file"
text = "���{�ꂪUTF-8�ŏ������܂�邩�H
���s�������邩�H"
f = FileWsh.open("test_text.txt", "w")
f.write(text)
f.write("write��2��ǂ�ł��ǉ�����邩�H")
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
  fff.write("�u���b�N���珑���Ă��܂�")
  fff.write("�ނ��Ⴍ���Ꮡ���Ă��܂�")
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


