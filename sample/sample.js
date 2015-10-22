/* Generated by Opal 0.8.1 */
(function(Opal) {
  Opal.dynamic_require_severity = "error";
  function $rb_plus(lhs, rhs) {
    return (typeof(lhs) === 'number' && typeof(rhs) === 'number') ? lhs + rhs : lhs['$+'](rhs);
  }
  var self = Opal.top, $scope = Opal, nil = Opal.nil, $breaker = Opal.breaker, $slice = Opal.slice;

  Opal.add_stubs(['$each', '$to_s']);
  Opal.Object.$$proto.$puts = function(ary) {
    var $a, $b, TMP_1, self = this, tmp = nil;

    ary = $slice.call(arguments, 0);
    tmp = "";
    ($a = ($b = ary).$each, $a.$$p = (TMP_1 = function(a){var self = TMP_1.$$s || this;
if (a == null) a = nil;
    return tmp = $rb_plus(tmp, a.$to_s())}, TMP_1.$$s = self, TMP_1), $a).call($b);
    return WScript.Echo(tmp);
  };
  return (Opal.Object.$$proto.$print = function(ary) {
    var $a, $b, TMP_2, self = this, tmp = nil;

    ary = $slice.call(arguments, 0);
    tmp = "";
    ($a = ($b = ary).$each, $a.$$p = (TMP_2 = function(a){var self = TMP_2.$$s || this;
if (a == null) a = nil;
    return tmp = $rb_plus(tmp, a.$to_s())}, TMP_2.$$s = self, TMP_2), $a).call($b);
    return WScript.Echo(tmp);
  }, nil) && 'print';
})(Opal);
/* Generated by Opal 0.8.1 */
(function(Opal) {
  Opal.dynamic_require_severity = "error";
  var $a, $b, TMP_1, $c, TMP_2, $d, TMP_3, self = Opal.top, $scope = Opal, nil = Opal.nil, $breaker = Opal.breaker, $slice = Opal.slice, text = nil, f = nil, text_r = nil;

  Opal.add_stubs(['$require', '$puts', '$exist?', '$split', '$basename', '$dirname', '$join', '$folder?', '$directory?', '$exists?', '$mv_dir_name', '$mv_dir', '$rmdir', '$mkdir', '$cp_r', '$open', '$write', '$close', '$read', '$glob_files', '$glob_dirs', '$glob']);
  self.$require("opal");
  self.$require("native");
  self.$require("filewsh");
  self.$puts("### FileWsh Test");
  self.$puts("a.txt? : ", $scope.get('FileWsh')['$exist?']("a.txt"));
  self.$puts("none.txt? : ", $scope.get('FileWsh')['$exist?']("none.txt"));
  self.$puts("### FileWsh Original Method");
  self.$puts("aabbcc".$split("bb"));
  self.$puts("basename : ", $scope.get('FileWsh').$basename("test/test.rb"));
  self.$puts("dirname : ", $scope.get('FileWsh').$dirname("C:/temp/test_dir/test_file.rb"));
  self.$puts("join : ", $scope.get('FileWsh').$join("C:", "test", "dir", "test.rb"));
  self.$puts("split : ", $scope.get('FileWsh').$split("C:/test_dir/more_dir/test.rb"));
  self.$puts("folder? dir: ", $scope.get('FileWsh')['$folder?']("test_exist_dir"));
  self.$puts("folder? file: ", $scope.get('FileWsh')['$folder?']("a.txt"));
  self.$puts("directory? dir: ", $scope.get('FileWsh')['$directory?']("test_exist_dir"));
  self.$puts("directory? file: ", $scope.get('FileWsh')['$directory?']("a.txt"));
  self.$puts("Dir.exists? dir: ", $scope.get('DirWsh')['$exists?']("test_exist_dir"));
  self.$puts("Dir.exists? file: ", $scope.get('DirWsh')['$exists?']("a.txt"));
  self.$puts("### mv dir name");
  if ((($a = $scope.get('DirWsh')['$exists?']("test_dir")) !== nil && (!$a.$$is_boolean || $a == true))) {
    self.$puts("test_dirをtest_dir2へリネームします");
    $scope.get('FileUtilWsh').$mv_dir_name("test_dir", "test_dir2");
    } else {
    self.$puts("test_dir2をtest_dirへリネームします");
    $scope.get('FileUtilWsh').$mv_dir_name("test_dir2", "test_dir");
  };
  self.$puts("mv dir");
  if ((($a = $scope.get('DirWsh')['$exists?']("test/A/田中")) !== nil && (!$a.$$is_boolean || $a == true))) {
    self.$puts("test/A/田中ディレクトリがあります。");
    self.$puts("test/B/へ田中ディレクトリを移動します。");
    $scope.get('FileUtilWsh').$mv_dir("test/A/田中", "test/B/");
    } else {
    self.$puts("test/A/へ田中ディレクトリを移動します。");
    $scope.get('FileUtilWsh').$mv_dir("test/B/田中", "test/A/");
  };
  self.$puts("mkdir");
  if ((($a = $scope.get('DirWsh')['$exists?']("test/D")) !== nil && (!$a.$$is_boolean || $a == true))) {
    self.$puts("test/Dディレクトリがあります。削除します。");
    $scope.get('FileUtilWsh').$rmdir("test/D");
    } else {
    self.$puts("test/Dディレクトリがありません。作成します。");
    $scope.get('FileUtilWsh').$mkdir("test/D");
  };
  if ((($a = $scope.get('DirWsh')['$exists?']("test/C/鈴木")) !== nil && (!$a.$$is_boolean || $a == true))) {
    self.$puts("test/C/鈴木があります。削除します。");
    $scope.get('FileUtilWsh').$rmdir("test/C/鈴木");
    } else {
    self.$puts("test/C/鈴木がありません。コピーします。");
    $scope.get('FileUtilWsh').$cp_r("test/src/鈴木", "test/C/鈴木");
  };
  self.$puts("### Write file");
  text = "日本語がUTF-8で書き込まれるか？\n改行もいけるか？";
  f = $scope.get('FileWsh').$open("test_text.txt", "w");
  f.$write(text);
  f.$write("writeを2回読んでも追加されるか？");
  f.$close();
  self.$puts("");
  self.$puts("### Read file");
  f = $scope.get('FileWsh').$open("test_text.txt", "r");
  text_r = f.$read();
  f.$close();
  self.$puts("Read : ", text_r);
  self.$puts("");
  self.$puts("### Write file using block");
  ($a = ($b = $scope.get('FileWsh')).$open, $a.$$p = (TMP_1 = function(fff){var self = TMP_1.$$s || this;
if (fff == null) fff = nil;
  fff.$write("ブロックから書いています");
    return fff.$write("むちゃくちゃ書いています");}, TMP_1.$$s = self, TMP_1), $a).call($b, "test_text_block.txt", "w");
  self.$puts("Read : ", $scope.get('FileWsh').$open("test_text_block.txt", "r").$read());
  self.$puts("");
  self.$puts("### Open file mode a");
  ($a = ($c = $scope.get('FileWsh')).$open, $a.$$p = (TMP_2 = function(ffw){var self = TMP_2.$$s || this;
if (ffw == null) ffw = nil;
  ffw.$write("log 1");
    return ffw.$write("log 2");}, TMP_2.$$s = self, TMP_2), $a).call($c, "test_text_mode_a.txt", "w");
  ($a = ($d = $scope.get('FileWsh')).$open, $a.$$p = (TMP_3 = function(ffa){var self = TMP_3.$$s || this;
if (ffa == null) ffa = nil;
  ffa.$write("log 3");
    return ffa.$write("log 4");}, TMP_3.$$s = self, TMP_3), $a).call($d, "test_text_mode_a.txt", "a");
  self.$puts("Read : ");
  self.$puts($scope.get('FileWsh').$open("test_text_mode_a.txt", "r").$read());
  self.$puts("### Files");
  self.$puts($scope.get('DirWsh').$glob_files("./"));
  self.$puts("");
  self.$puts("### Dirs");
  self.$puts($scope.get('DirWsh').$glob_dirs("./"));
  self.$puts("");
  self.$puts("### Files and Dirs");
  return self.$puts($scope.get('DirWsh').$glob("./"));
})(Opal);
