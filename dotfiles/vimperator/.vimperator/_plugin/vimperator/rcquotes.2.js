/*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <maglione.k@gmail.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.       Kris Maglione
 * ---------------------------------------------------------------------------
 * <phk@FreeBSD.ORG> wrote this license.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
 * ---------------------------------------------------------------------------
 */

const quoteMap = {
    "\n": "n",
    "\t": "t"
}
function quote(q, list)
{
    let re = RegExp("[" + list + "]", "g");
    return function (str) q + String.replace(str, re, function ($0) $0 in quoteMap ? quoteMap[$0] : ("\\" + $0)) + q;
}

const complQuote = { // FIXME
    '"': ['"', function (str) { let s = String.quote(str); return s.substr(1, s.length - 2) }, '"'],
    "'": ["'", function (str) str.replace("'", "''", "g"), "'"],
    "":  ["", quote("",  "\\\\ "), ""]
};
const quoteArg = {
    '"': String.quote,
    "'": function (str) "'" + str.replace("'", "''", "g") + "'",
    "":  quote("",  "\\\\ ")
};

for (let [k, v] in Iterator(quoteArg))
    commands.quoteArg[k] = v;
for (let [k, v] in Iterator(complQuote))
    commands.complQuote[k] = v;

commands.parseArg = function parseArg(str) {
    let arg = "";
    let quote = null;
    let len = str.length;

    while (str.length && !/^\s/.test(str))
    {
        let res;

        [res] = str.match(/^(?:[^\\\s"']|\\.|\\$)*/);
        arg += res.replace(/\\(.)/g, function (_0, _1) /[\s\\]/.test(_1) ? _1 : "\\" + _1);
        str = str.substr(res.length);

        if (res = str.match(/^(")((?:[^\\"]|\\.)*)("?)/))
            arg += eval(res[0] + (res[3] ? "" : '"'));
        else if (res = str.match(/^(')((?:[^']|'')*)('?)/))
            arg += res[2].replace("''", "'", "g");

        if (res)
        {
            if (!res[3])
                quote = res[1];
            str = str.substr(res[0].length);
        }
    }

    return [len - str.length, arg, quote];
}

