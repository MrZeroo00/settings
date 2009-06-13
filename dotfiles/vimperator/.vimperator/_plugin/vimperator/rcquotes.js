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
    '"': ['"', quote("", '\n\t"\\\\'), '"'],
    "'": ["'", function (str) str.replace("'", "''", "g"), "'"],
    "":  ["", quote("",  "\\\\ "), ""]
};
const quoteArg = {
    '"': quote('"', '\n\t"\\\\'),
    "'": function (str) "'" + str.replace("'", "''", "g") + "'",
    "":  quote("",  "\\\\ ")
};

for (let [k, v] in Iterator(quoteArg))
    commands.quoteArg[k] = v;
for (let [k, v] in Iterator(complQuote))
    commands.complQuote[k] = v;

// returns [count, parsed_argument]
commands.parseArg = function getNextArg(str)
{
    var stringDelimiter = null;
    var escapeNext = false;

    var arg = "";

    outer:
    for (let [i, c] in Iterator(str))
    {
	inner:
        switch (c) {
        case '"':
            if (escapeNext)
                break;
            switch (stringDelimiter)
            {
                case c:
                    stringDelimiter = null;
                    continue outer;
                case null:
                    stringDelimiter = c;
                    continue outer;
            }
            break;

        case "'":
            if (escapeNext)
                break;
            if (str[i + 1] == "'") {
                escapeNext = true;
                continue outer;
            }

            if (stringDelimiter == null)
                stringDelimiter = "'";
            else if (stringDelimiter == "'")
                stringDelimiter = null;
            else
                break;
            continue outer;

        // \ is an escape key for non quoted or "-quoted strings
        // for '-quoted strings it is taken literally, apart from \' and \\
        case "\\":
            if (escapeNext || stringDelimiter == "'")
                break;
            else
            {
                // in non-quoted strings, only escape "\\" and "\ ", otherwise drop "\\"
                if (!stringDelimiter && str[i + 1] != "\\" && str[i + 1] != " ")
                    continue outer;
                escapeNext = true;
                continue outer;
            }
            break;

        default:
            if (stringDelimiter == "'")
                break;
            if (escapeNext)
            {
                escapeNext = false;
                switch (c)
                {
                    case "n": arg += "\n"; break;
                    case "t": arg += "\t"; break;
                    default:
                        break inner; // this makes "a\fb" -> afb; wanted or should we return ab? --mst
                }
                continue outer;
            }
            else if (!stringDelimiter && /\s/.test(c))
            {
                return [i, arg];
            }
            break;
	}
        escapeNext = false;
	arg += c;
    }

    // TODO: add parsing of a " comment here:
    if (stringDelimiter)
	return [str.length, arg, stringDelimiter];
    if (escapeNext)
	return [str.length, arg, "\\"];
    else
	return [str.length, arg];
};

