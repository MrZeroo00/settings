(function () {
  let localfilepath = liberator.globalVariables.bm_filepath || io.expandPath('~/.vimp_bookmark');
  let charset = 'UTF-8';

  function filepath () {
    let result = Cc["@mozilla.org/file/local;1"].createInstance(Ci.nsILocalFile);
    result.initWithPath(localfilepath);
    return result;
  }

  function puts (line) {
    line = line + "\t" + content.document.location + "\n";
    let out = Cc["@mozilla.org/network/file-output-stream;1"].createInstance(Ci.nsIFileOutputStream);
    let conv = Cc['@mozilla.org/intl/converter-output-stream;1'].
      createInstance(Ci.nsIConverterOutputStream);
    out.init(filepath(), 0x02 | 0x10 | 0x08, 0664, 0);
    conv.init(out, charset, line.length,
              Components.interfaces.nsIConverterInputStream.DEFAULT_REPLACEMENT_CHARACTER);
    conv.writeString(line);
    conv.close();
    out.close();
  }

  commands.addUserCommand(
    ['bm'],
    'Bookmark to text',
    function (arg) {
      if (arg.string) {
        puts(arg.string);
      }
    }
  );
})();
