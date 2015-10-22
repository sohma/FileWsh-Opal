module FileTest
  Separator = SEPARATOR = '/'
  ALT_SEPARATOR = nil
  PATH_SEPARATOR = ':'

  def buildFileObject
    `new ActiveXObject("Scripting.FileSystemObject")`
  end

  def folder?(file)
    rs = false
    ->{ %x{
        #{rs} = #{buildFileObject}.FolderExists(#{file})
      }}.()
    rs
  end
  alias directory? folder?

  def exist?(file_path)
    rs = false
    ->{ %x{
      #{rs} = #{buildFileObject}.FileExists(#{file_path});
    }}.()
    rs
  end
  alias exists? exist?
end


class FileWsh < IO
  extend FileTest


  class << self

    def expand_path(path, basedir = nil)
      path = [basedir, path].compact.join(SEPARATOR)
      parts = path.split(SEPARATOR)
      new_parts = []
      parts[0] = Dir.home if parts.first == '~'

      parts.each do |part|
        if part == '..'
          new_parts.pop
        else
          new_parts << part
        end
      end
      new_parts.join(SEPARATOR)
    end

    def dirname(path)
      path.split(SEPARATOR)[0..-2]
    end

    def basename(path)
	    puts "call basename"
      path.split(SEPARATOR)[-1]
    end

    def join(*paths)
      paths.join(SEPARATOR).gsub(%r{#{SEPARATOR}+}, SEPARATOR)
    end

    def split(path)
      path.split(SEPARATOR)
    end

  #-orignal

    def open(file_name, mode)
      file = FileWsh.new(file_name, mode)
      if block_given?
        begin
          yield(file)
        ensure
          file.close
        end
      else
        file
      end
    end

  end

  def initialize(file_name, mode)
    @file_name = file_name
    @mode = mode

    @AD_TYPE_BINARY = 1
    @AD_TYPE_TEXT = 2
    @AD_READ_ALL = -1
    @AD_READ_LINE = -2
    @AD_WRITE_CHAR = 0
    @AD_WRITE_LINE = 1
    @AD_SAVE_CREATE_NOT_EXIST = 1
    @AD_SAVE_CREATE_OVER_WRITE= 2
    @AD_MODE_READ_WRITE = 3

    %x{
      #{@fd} = new ActiveXObject("ADODB.Stream");
      #{@fd}.Type = #{@AD_TYPE_TEXT};
      #{@fd}.charset = "UTF-8";
      #{@fd}.Mode = #{@AD_MODE_READ_WRITE};
      #{@fd}.Open();
    }
    if @mode == "a"
      %x{
        #{@fd}.LoadFromFile(#{@file_name});
        #{@fd}.ReadText( #{@AD_READ_ALL} );
      }
    end
  end

  def read
    lines = ""
    %x{
      #{@fd}.LoadFromFile(#{@file_name});
      #{lines} = #{@fd}.ReadText( #{@AD_READ_ALL} );
    }
    lines
  end

  def write(text)
    %x{
      #{@fd}.WriteText(#{text}, #{@AD_WRITE_LINE});
    }
  end

  def close()
    if @mode == "w" || @mode == "a"
      %x{
        #{@fd}.SaveToFile( #{@file_name}, #{@AD_SAVE_CREATE_OVER_WRITE} );
        #{@fd}.Close();
      }
    else
      `#{@fd}.Close()`
    end
  end
end




class DirWsh < IO
  extend FileTest

  class << self
    def exist?(dir_path)
      directory?(dir_path)
    end
    alias exists? exist?

    def glob_files(dir_path)
      files = []
      ->{
        %x{
          var fs = new ActiveXObject("Scripting.FileSystemObject");
          var folder = fs.GetFolder(#{dir_path});
          var em = new Enumerator(folder.Files);
          for (em.moveFirst(); !em.atEnd(); em.moveNext() )
            #{files << `em.item().Name`};
          fs = null;
        }
      }.()
      files
    end

    def glob_dirs(dir_path)
      dirs = []
      ->{
        %x{
          var fs = new ActiveXObject("Scripting.FileSystemObject");
          var folder = fs.GetFolder(#{dir_path});
          var em = new Enumerator( folder.SubFolders );
          for ( em.moveFirst(); !em.atEnd(); em.moveNext() )
            #{dirs << `em.item().Name`};
          fs = null;
        }
      }.()
      dirs
    end

    def glob(dir_path)
      files =  glob_files(dir_path)
      dirs = glob_dirs(dir_path)
      files + dirs
    end

  end
end

class FileUtilWsh < IO
  extend FileTest

  class << self

    def mv_dir_name(src_name, dest_name)
      ->{ %x{
        #{buildFileObject}.GetFolder(#{src_name}).Name = #{dest_name}
      }}.()
      dest_name 
    end

    def mv_dir(src_dir, dest_dir)
      ->{ %x{
        #{buildFileObject}.MoveFolder(#{src_dir}, #{dest_dir})
      }}.()
      dest_dir 
    end

    def cp_r(src_dir, dest_dir)
      ->{ %x{
        #{buildFileObject}.CopyFolder(#{src_dir}, #{dest_dir})
      }}.()
      dest_dir 
    end

    def mkdir(dir_path)
      ->{ %x{
        #{buildFileObject}.CreateFolder(#{dir_path})
      }}.() 
      dir_path
    end

    def rmdir(dir_path)
      ->{ %x{
          #{buildFileObject}.DeleteFolder(#{dir_path})
      }}.()
      dir_path
    end
  end
end
