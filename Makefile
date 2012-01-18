PACKAGE = html5shiv

all: $(PACKAGE)

$(PACKAGE):
	cat src/html5shiv-printshiv.js | \
		sed 's/})(this, document);/})(d.parentWindow,d);/' | \
		yui-compressor --type js --charset UTF-8 | \
		sed 's/\w*\.createDocumentFragment\s*=\s*function/if(\/*@cc_on@if(@_jscript_version>=5.6)true@else@*\/false\/*@end@*\/)\0/' | \
		sed '1i<PUBLIC:ATTACH EVENT="ondocumentready" HANDLER="h"\/><SCRIPT LANGUAGE="JScript">var h=\/*@cc_on@if(@_jscript_version<9)true@else@*\/false\/*@end@*\/?function(){var d=element.document;' | \
		sed '$$ad.body.innerHTML+="";}:function(){}<\/SCRIPT>' \
		> $(PACKAGE).htc

.PHONY: clean
clean:
	-rm -f $(PACKAGE).htc
