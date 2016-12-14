@if (@X==@Y) @then
:: Batch
@echo off & setlocal enableextensions disabledelayedexpansion
(call;)

cscript //nologo //e:jscript "%~dpf0" "%~dpf1"

endlocal & exit /b %errorlevel%

@end // JScript

// functions:
// returns string holding ccontents of file
function readFile(filename) {
    if (!fso.FileExists(filename)) {
        WSH.StdErr.WriteLine('file not found: "' + filename + '"');
        WSH.Quit(1);
    } // if
    var fileObj = fso.OpenTextFile(filename, 1, false, 0),
        lines = '';
    while (!fileObj.AtEndOfStream) {
        lines = lines + fileObj.ReadLine() + '\n';
    } // while
    fileObj.Close();
    return lines;
} // readFile

// MD5 from http://stackoverflow.com/a/33486055
function MD5(s) {
    function L(k, d) {
        return (k << d) | (k >>> (32 - d))
    }

    function K(G, k) {
        var I, d, F, H, x;
        F = (G & 2147483648);
        H = (k & 2147483648);
        I = (G & 1073741824);
        d = (k & 1073741824);
        x = (G & 1073741823) + (k & 1073741823);
        if (I & d) {
            return (x ^ 2147483648 ^ F ^ H)
        }
        if (I | d) {
            if (x & 1073741824) {
                return (x ^ 3221225472 ^ F ^ H)
            } else {
                return (x ^ 1073741824 ^ F ^ H)
            }
        } else {
            return (x ^ F ^ H)
        }
    }

    function r(d, F, k) {
        return (d & F) | ((~d) & k)
    }

    function q(d, F, k) {
        return (d & k) | (F & (~k))
    }

    function p(d, F, k) {
        return (d ^ F ^ k)
    }

    function n(d, F, k) {
        return (F ^ (d | (~k)))
    }

    function u(G, F, aa, Z, k, H, I) {
        G = K(G, K(K(r(F, aa, Z), k), I));
        return K(L(G, H), F)
    }

    function f(G, F, aa, Z, k, H, I) {
        G = K(G, K(K(q(F, aa, Z), k), I));
        return K(L(G, H), F)
    }

    function D(G, F, aa, Z, k, H, I) {
        G = K(G, K(K(p(F, aa, Z), k), I));
        return K(L(G, H), F)
    }

    function t(G, F, aa, Z, k, H, I) {
        G = K(G, K(K(n(F, aa, Z), k), I));
        return K(L(G, H), F)
    }

    function e(G) {
        var Z;
        var F = G.length;
        var x = F + 8;
        var k = (x - (x % 64)) / 64;
        var I = (k + 1) * 16;
        var aa = Array(I - 1);
        var d = 0;
        var H = 0;
        while (H < F) {
            Z = (H - (H % 4)) / 4;
            d = (H % 4) * 8;
            aa[Z] = (aa[Z] | (G.charCodeAt(H) << d));
            H++
        }
        Z = (H - (H % 4)) / 4;
        d = (H % 4) * 8;
        aa[Z] = aa[Z] | (128 << d);
        aa[I - 2] = F << 3;
        aa[I - 1] = F >>> 29;
        return aa
    }

    function B(x) {
        var k = "",
            F = "",
            G, d;
        for (d = 0; d <= 3; d++) {
            G = (x >>> (d * 8)) & 255;
            F = "0" + G.toString(16);
            k = k + F.substr(F.length - 2, 2)
        }
        return k
    }

    function J(k) {
        k = k.replace(/rn/g, "n");
        var d = "";
        for (var F = 0; F < k.length; F++) {
            var x = k.charCodeAt(F);
            if (x < 128) {
                d += String.fromCharCode(x)
            } else {
                if ((x > 127) && (x < 2048)) {
                    d += String.fromCharCode((x >> 6) | 192);
                    d += String.fromCharCode((x & 63) | 128)
                } else {
                    d += String.fromCharCode((x >> 12) | 224);
                    d += String.fromCharCode(((x >> 6) & 63) | 128);
                    d += String.fromCharCode((x & 63) | 128)
                }
            }
        }
        return d
    }
    var C = Array();
    var P, h, E, v, g, Y, X, W, V;
    var S = 7,
        Q = 12,
        N = 17,
        M = 22;
    var A = 5,
        z = 9,
        y = 14,
        w = 20;
    var o = 4,
        m = 11,
        l = 16,
        j = 23;
    var U = 6,
        T = 10,
        R = 15,
        O = 21;
    s = J(s);
    C = e(s);
    Y = 1732584193;
    X = 4023233417;
    W = 2562383102;
    V = 271733878;
    for (P = 0; P < C.length; P += 16) {
        h = Y;
        E = X;
        v = W;
        g = V;
        Y = u(Y, X, W, V, C[P + 0], S, 3614090360);
        V = u(V, Y, X, W, C[P + 1], Q, 3905402710);
        W = u(W, V, Y, X, C[P + 2], N, 606105819);
        X = u(X, W, V, Y, C[P + 3], M, 3250441966);
        Y = u(Y, X, W, V, C[P + 4], S, 4118548399);
        V = u(V, Y, X, W, C[P + 5], Q, 1200080426);
        W = u(W, V, Y, X, C[P + 6], N, 2821735955);
        X = u(X, W, V, Y, C[P + 7], M, 4249261313);
        Y = u(Y, X, W, V, C[P + 8], S, 1770035416);
        V = u(V, Y, X, W, C[P + 9], Q, 2336552879);
        W = u(W, V, Y, X, C[P + 10], N, 4294925233);
        X = u(X, W, V, Y, C[P + 11], M, 2304563134);
        Y = u(Y, X, W, V, C[P + 12], S, 1804603682);
        V = u(V, Y, X, W, C[P + 13], Q, 4254626195);
        W = u(W, V, Y, X, C[P + 14], N, 2792965006);
        X = u(X, W, V, Y, C[P + 15], M, 1236535329);
        Y = f(Y, X, W, V, C[P + 1], A, 4129170786);
        V = f(V, Y, X, W, C[P + 6], z, 3225465664);
        W = f(W, V, Y, X, C[P + 11], y, 643717713);
        X = f(X, W, V, Y, C[P + 0], w, 3921069994);
        Y = f(Y, X, W, V, C[P + 5], A, 3593408605);
        V = f(V, Y, X, W, C[P + 10], z, 38016083);
        W = f(W, V, Y, X, C[P + 15], y, 3634488961);
        X = f(X, W, V, Y, C[P + 4], w, 3889429448);
        Y = f(Y, X, W, V, C[P + 9], A, 568446438);
        V = f(V, Y, X, W, C[P + 14], z, 3275163606);
        W = f(W, V, Y, X, C[P + 3], y, 4107603335);
        X = f(X, W, V, Y, C[P + 8], w, 1163531501);
        Y = f(Y, X, W, V, C[P + 13], A, 2850285829);
        V = f(V, Y, X, W, C[P + 2], z, 4243563512);
        W = f(W, V, Y, X, C[P + 7], y, 1735328473);
        X = f(X, W, V, Y, C[P + 12], w, 2368359562);
        Y = D(Y, X, W, V, C[P + 5], o, 4294588738);
        V = D(V, Y, X, W, C[P + 8], m, 2272392833);
        W = D(W, V, Y, X, C[P + 11], l, 1839030562);
        X = D(X, W, V, Y, C[P + 14], j, 4259657740);
        Y = D(Y, X, W, V, C[P + 1], o, 2763975236);
        V = D(V, Y, X, W, C[P + 4], m, 1272893353);
        W = D(W, V, Y, X, C[P + 7], l, 4139469664);
        X = D(X, W, V, Y, C[P + 10], j, 3200236656);
        Y = D(Y, X, W, V, C[P + 13], o, 681279174);
        V = D(V, Y, X, W, C[P + 0], m, 3936430074);
        W = D(W, V, Y, X, C[P + 3], l, 3572445317);
        X = D(X, W, V, Y, C[P + 6], j, 76029189);
        Y = D(Y, X, W, V, C[P + 9], o, 3654602809);
        V = D(V, Y, X, W, C[P + 12], m, 3873151461);
        W = D(W, V, Y, X, C[P + 15], l, 530742520);
        X = D(X, W, V, Y, C[P + 2], j, 3299628645);
        Y = t(Y, X, W, V, C[P + 0], U, 4096336452);
        V = t(V, Y, X, W, C[P + 7], T, 1126891415);
        W = t(W, V, Y, X, C[P + 14], R, 2878612391);
        X = t(X, W, V, Y, C[P + 5], O, 4237533241);
        Y = t(Y, X, W, V, C[P + 12], U, 1700485571);
        V = t(V, Y, X, W, C[P + 3], T, 2399980690);
        W = t(W, V, Y, X, C[P + 10], R, 4293915773);
        X = t(X, W, V, Y, C[P + 1], O, 2240044497);
        Y = t(Y, X, W, V, C[P + 8], U, 1873313359);
        V = t(V, Y, X, W, C[P + 15], T, 4264355552);
        W = t(W, V, Y, X, C[P + 6], R, 2734768916);
        X = t(X, W, V, Y, C[P + 13], O, 1309151649);
        Y = t(Y, X, W, V, C[P + 4], U, 4149444226);
        V = t(V, Y, X, W, C[P + 11], T, 3174756917);
        W = t(W, V, Y, X, C[P + 2], R, 718787259);
        X = t(X, W, V, Y, C[P + 9], O, 3951481745);
        Y = K(Y, h);
        X = K(X, E);
        W = K(W, v);
        V = K(V, g)
    }
    var i = B(Y) + B(X) + B(W) + B(V);
    return i.toLowerCase();
} // MD5

// returns line no of invalid key-value headder
function findLineNo(text, pattern) {
    var allLines = text.split('\n'),
        i = 0;
    while (i < allLines.length) {
        if (!(pattern.test(allLines[i]))) break
        i++;
    } // while
    return i;
} // findLineNo

// validate key-value pairs in header block
function valHdrs(filename, lines) {
    filename = filename.replace(/\\(.+)$/, '$1');
    var errFlag = 1,
        offset = 2,
        hdrLines = '';
    if (!(/\.log/i.test(filename)) && !(/^blog\.cfg$/i.test(filename))) {
        switch (true) {
            case !(/^---\n/.test(lines)):
                WSH.StdErr.WriteLine('error on line 1 of file "' + filename +
                    '":\n' +
                    'missing start of header block');
                break;
            case /^---\n---\n/.test(lines):
                WSH.StdErr.WriteLine('error on line 2 of file "' + filename +
                    '":\n' +
                    'empty header block');
                break;
            case !(/^---\n(?:.+\n)+---\n/.test(lines)):
                lineNo = findLineNo(lines, /./);
                WSH.StdErr.WriteLine('error on line ' + (lineNo + 1) +
                    ' of file "' +
                    filename + '":\n' +
                    'blank lines not supported in header block');
                break;
            case !(
                /^---\n(?:(?:[^-].*\n)|(?:-(?:[^-].*\n|\n))|(?:--(?:[^-].*\n|\n))|(?:---.+\n))+---\n/
                .test(lines)):
                WSH.StdErr.WriteLine('error in file "' + filename + '":\n' +
                    'missing end of header block');
                break;
            case !(/^---\n(?:.+\n)+---\n\n/.test(lines)):
                lineNo = findLineNo(lines.replace('---\n', ''), /^(?!---$).*$/);
                WSH.StdErr.WriteLine('error on line ' + (lineNo + 3) +
                    ' of file "' +
                    filename + '":\n' +
                    'blank line required after header block');
                break;
            default:
                errFlag = 0;
                break;
        } // switch
        errFlag ? WSH.Quit(1) : errFlag = 1;
        hdrLines = lines.
        match(
            /^---\n((?:(?:[^-].*\n)|(?:-(?:[^-].*\n|\n))|(?:--(?:[^-].*\n|\n))|(?:---.+\n))+)---\n/
        )[1];
    } else {
        offset--;
        hdrLines = lines;
    }
    switch (true) {
        case !(/^(?:.+\n)+$/.test(hdrLines)):
            lineNo = findLineNo(lines, /./);
            WSH.StdErr.WriteLine('error on line ' + (lineNo + 1) + ' of file "' +
                filename + '":\n' + 'blank lines not supported');
            break;
        case !(/^(?:.*:.*\n)+$/.test(hdrLines)):
            lineNo = findLineNo(hdrLines, /:/);
            WSH.StdErr.WriteLine('error on line ' + (lineNo + offset) +
                ' of file "' +
                filename + '":\n' + 'separator (:) not found');
            break;
        case !(/^(?:[a-z0-9](?:[_-](?=[a-z0-9])|[a-z0-9])*:.*\n)+$/.test(
            hdrLines)):
            lineNo = findLineNo(hdrLines,
                /^[a-z0-9](?:[_-](?=[a-z0-9])|[a-z0-9])*:/);
            WSH.StdErr.WriteLine('error on line ' + (lineNo + offset) +
                ' of file "' +
                filename + '":\n' + 'missing or badly formed key');
            break;
        case !(/^(?:[a-z0-9_-]{1,20}:.*\n)+$/.test(hdrLines)):
            lineNo = findLineNo(hdrLines, /^[a-z0-9_-]{1,20}:/);
            WSH.StdErr.WriteLine('error on line ' + (lineNo + offset) +
                ' of file "' +
                filename + '":\n' + 'key too long (20 char max)');
            break;
        case !(/^(?:[^:]+:[ \t]+.+\n)+$/.test(hdrLines)):
            lineNo = findLineNo(hdrLines, /^.+?:[ \t]+.+$/);
            WSH.StdErr.WriteLine('error on line ' + (lineNo + offset) +
                ' of file "' +
                filename + '":\n' + 'missing or badly formed value');
            break;
        default:
            errFlag = 0;
            break;
    } // switch
    if (errFlag) WSH.Quit(1);
    hdrLines = hdrLines.replace(/\n+$/, '');
    var hdrArray = hdrLines.split('\n'),
        i = 0,
        key, hdrHash = {};
    while (i < hdrArray.length) {
        key = hdrArray[i].match(/^(.+?):/)[1];
        if (hdrHash[key] == undefined) {
            hdrHash[key] = hdrArray[i].match(/^.+?:[ \t]+(.+)$/)[1];
        } else {
            WSH.StdErr.WriteLine('error on line ' + (i + 1) + ' of file "' +
                filename +
                '":\nkey "' + key + '" already defined');
            WSH.Quit(1);
        } // if
        i++
    } // while
    return hdrHash;
} // valHdrs

// doubles backslashes and converts all &, <, and > symbols into HTML entities
function Entify(str) {
    return str.replace(/\\/g, '\\\\').replace(/&/g, '&amp;')
        .replace(/</g, '&lt;').replace(/>/g, '&gt;');
} // Entify

// returns <member>...</member> XML entry for header name and value
function Memberise(hdrName, hdrValue) {
    return '<member><name>' + hdrName + '</name><value>' + hdrValue +
        '</value></member>\n';
} // Memberise

// validate date-time string
function valDateTime(dtStr) {
    if (!(
            /^\d{4}\/\d\d\/\d\d \d\d:\d\d(?::\d\d)?(?: utc(?:[+-](?:[1-9]|1[012]))?)?$/i
            .test(dtStr))) {
        WScript.StdErr.WriteLine('date-time must be in the format:\r\n\r\n' +
            '  yyyy/mm/dd HH:MM[:SS][ UTC[(+/-)1-12]]\r\n\r\n' +
            'where the values have the following ranges:\r\n\r\n' +
            ' yyyy:  1000 - 9999\r\n' +
            '    mm:  01 - 12\r\n' +
            '    dd:  01 - 31\r\n' +
            '    HH:  00 - 23\r\n' +
            '    MM:  00 - 59\r\n' +
            '    SS:  00 - 59\r\n\r\n' +
            'and timezone must be in one of the following formats:\r\n\r\n' +
            '  UTC\r\n' +
            '  UTC+[1-12]\r\n' +
            '  UTC-[1-12]');
        WSH.Quit(1);
    } else {
        var valDTStr = dtStr.toUpperCase();
    }
    var y4Str = dtStr.substr(0, 4);
    var monStr = dtStr.substr(5, 2);
    var dayStr = dtStr.substr(8, 2);
    var hrStr = dtStr.substr(11, 2);
    var minStr = dtStr.substr(14, 2);
    dtStr = dtStr.substr(16);
    var secStr = '00',
        tzStr = '';
    if (dtStr != '') {
        if (/^:\d\d/.test(dtStr)) {
            secStr = dtStr.substr(1, 2);
            dtStr = dtStr.substr(3);
        }
    }
    if (dtStr != '') tzStr = dtStr.substr(1).toUpperCase();
    var errFlag = 0;
    switch (false) {
        case /^[1-9][0-9]{3}$/.test(y4Str):
            WScript.StdErr.WriteLine('year must be within range of 1000-9999');
            errFlag = 1;
            break;
        case /^0[1-9]|1[012]$/.test(monStr):
            WScript.StdErr.WriteLine('month must be within range of 01-12');
            errFlag = 1;
            break;
        case /^0[1-9]|[12][0-9]|3[01]$/.test(dayStr):
            WScript.StdErr.WriteLine('day must be within range of 01-31');
            errFlag = 1;
            break;
        case /^[01][0-9]|2[0-3]$/.test(hrStr):
            WScript.StdErr.WriteLine('hours must be within range of 00 - 23');
            errFlag = 1;
            break;
        case /^[0-5][0-9]$/.test(minStr):
            WScript.StdErr.WriteLine('minutes must be within range of 00 - 59');
            errFlag = 1;
            break;
        case /^[0-5][0-9]$/.test(secStr):
            WScript.StdErr.WriteLine('seconds must be within range of 00 - 59');
            errFlag = 1;
            break;
        default:
            break;
    } // switch
    if (errFlag) WSH.Quit(1);
    switch (monStr) {
        case '04':
        case '06':
        case '09':
        case '11':
            if (dayStr == '31') {
                WScript.StdErr.WriteLine('Apr, Jun, Sep, and Nov have 30 days');
                errFlag = 1;
            }
            break;
        case '02':
            if (/^3[01]$/.test(dayStr)) {
                WScript.StdErr.WriteLine('Feb has 28 days (29 in a leap year)');
                errFlag = 1;
            } else if (dayStr == '29' && new Date(y4Str, 1, 29).getDate() - 29) {
                WScript.Echo(y4Str + ' is not a leap year');
                errFlag = 1;
            }
            break;
        default:
            break;
    } // switch
    if (errFlag) WSH.Quit(1);
    return y4Str + '' + monStr + '' + dayStr + 'T' +
        hrStr + ':' + minStr + ':' + secStr;
} // valDateTime

// converts local date-time string to GMT/UTC
function ldt2GMT(ldtStr) {
    var ldt = new Date(ldtStr.substr(0, 4) + '/' + ldtStr.substr(4, 2) + '/' +
        ldtStr.substr(6, 2) + ' ' + ldtStr.substr(9));
    var gmtYear = ldt.getUTCFullYear();
    var gmtMon = padStr(ldt.getUTCMonth() + 1);
    var gmtDate = padStr(ldt.getUTCDate());
    var gmtHour = padStr(ldt.getUTCHours());
    var gmtMin = padStr(ldt.getUTCMinutes());
    var gmtSec = padStr(ldt.getUTCSeconds());
    return gmtYear + '' + gmtMon + '' + gmtDate + 'T' +
        gmtHour + ':' + gmtMin + ':' + gmtSec;
} // ldt2GMT

// converts multiline string to hash
function str2Hash(str) {
    var hdrArr = str.split('\n'),
        i = 0,
        key = '',
        hdrHash = {};
    while (i < hdrArr.length) {
        key = hdrArr[i].match(/^(.+?):/)[1];
        hdrHash[key] = hdrArr[i].match(/^.+?:[ \t]+(.+)$/)[1];
        i++;
    } // while
    return hdrHash;
} // str2Hash

// pad month/date/hour/min/sec
function padStr(str) {
    return str < 10 ? '0' + str : str;
} // padStr

// str1 is searched for matches with re1;
// results are further searched for matches with re2,
// and any matches are replaced with str2
function innerReplace(Str1, Re1, Re2, Str2) {
    var len = 0,
        matches, i;
    matches = Str1.match(Re1);
    if (matches !== null) {
        len = matches.length;
    }
    for (i = 0; i < len; i++) {
        Str1 = Str1.replace(matches[i], matches[i].replace(Re2, Str2));
    }
    return Str1;
} // innerReplace

// invokes pandoc to convert markdown to html
function mkd2HTML(filename) {
    var pdOpts, extsOff, extsOn, pd2HTML, htmlLines;
    // set pandoc options
    pdOpts = '--ascii --atx-headers --columns=1';
    // disabled extensions
    extsOff = '-auto_identifiers-example_lists-tex_math_dollars-citations';
    // enabled extensions
    extsOn = '+emoji+mmd_title_block';
    // pandoc cmd to generate html from markdown
    pd2HTML = WshShell.Exec('pandoc ' + pdOpts + ' -f markdown' +
        extsOff + extsOn + ' -t html "' + filename + '"');
    htmlLines = pd2HTML.StdOut.ReadAll();
    if (pd2HTML.ExitCode) {
        WSH.StdErr.WriteLine('pandoc error');
        WSH.Quit(1);
    }
    // zap any carriage returns
    htmlLines = htmlLines.replace(/\r+/g, '')
        // strip any trailing  spaces or tabs
        .replace(/[ \t]+\n/g, '\n')
        // hack to prevent autolinking of email & web addresses
        .replace(/(?:\&amp;#64;|\&amp;amp;#64;)/ig, '&#64;')
        .replace(/(?:\&amp;#46;|\&amp;amp;#46;)/ig, '&#46;')
        // remove any trailing newlines from opening HTML tags
        .replace(/\n+((?:<[\w-]+[^>\n]*?>)+)\n+/g, '\n$1')
        .replace(/((?:<[\w-]+[^>\n]*?>)+)\n+((?:<[\w-]+[^>\n]*?>)+)/g, '$1$2')
        // ensure table cells belonging to 1 row are on 1 line
        .replace(/<\/td>\n+<td/ig, '<\/td><td')
        // remove any leading newlines from dangling HTML closing tags
        .replace(/\n+((?:<\/[\w-]+>)+)/g, '$1')
        // ensure 2 newlines after below HTML closing tags at EOL
        .replace(
            /(<\/(?:blockquote|div|dl|h[1-6]|ol|p|pre|table|tr|ul)>|-->)\n+/ig,
            '$1\n\n')
        // ensure 2 newlines after paragraphs wrapped inside list items/data definitions
        .replace(/(<\/p><\/li>|<\/p><\/dd>)\n+/ig, '$1\n\n')
        // remove "<!-- shortcode" and "/shortcode -->" comments
        .replace(/\n[ \t]*<!--[ \t]*shortcode[ \t]*\n/ig, '\n')
        .replace(/\n[ \t]*\/shortcode[ \t]*-->[ \t]*\n/ig, '\n')
        // strip any leading or trailing newlines
        .replace(/^(?:[ \t]*\n)+|(?:[ \t]*\n)+$/g, '');
    // prevents inline code fragments from wrapping
    htmlLines = innerReplace(htmlLines, /<code>.+?<\/code>(?!<\/pre>)/ig,
        /[ \t]+/g, '&nbsp;');
    // restores literal quotes (") except inside html tags
    htmlLines = innerReplace(htmlLines, />[^<]+</g, /\&quot;/ig, '"');
    // restores literal apostrophes (') except inside html tags
    htmlLines = innerReplace(htmlLines, />[^<]+</g, /\&#39;/g, "'");
    return htmlLines;
} // mkd2HTML

// validate list of tags
function valTags(tagList) {
    switch (true) {
        case !(/^[a-z0-9 \t,_-]+$/.test(tagList)):
            WScript.StdErr.WriteLine(
                'list of tags may contain the following characters:\n' +
                'a-z (lowercase only) 0-9, space, tab, comma, -, and _');
            WSH.Quit(1);
            break;
        case /^(?:[ \t]+)?,|,(?:[ \t]+)?$/g.test(tagList):
            WScript.StdErr.WriteLine('leading/trailing commas in list of tags');
            WSH.Quit(1);
            break;
        case /,(?:[ \t]+)?,/g.test(tagList):
            WScript.StdErr.WriteLine(
                'two or more consecutive commas found in list of tags');
            WSH.Quit(1);
            break;
        case /,(?:[ \t]+)?[_-]|[_-](?:[ \t]+)?,/.test(',' + tagList + ','):
            WScript.StdErr.WriteLine('tags may not begin or end with _ or -');
            WSH.Quit(1);
            break;
        case /[_-]{2,}/.test(tagList):
            WScript.StdErr.WriteLine(
                'tags may not contain two or more consecutive _ or - chars'
            );
            WSH.Quit(1);
            break;
        default:
            break;
    } // switch
    var tagArr = tagList.split(','),
        i;
    for (i = 0; i < tagArr.length; i++) {
        tagArr[i] = tagArr[i].replace(/^[ \t]+|[ \t]+$/g, '')
            .replace(/[ \t]+/g, ' ');
    }
    tagArr = tagArr.sort();
    var uniqTags = [];
    for (i = 0; i < tagArr.length - 1; i++) {
        if (tagArr[i] != tagArr[i + 1]) uniqTags.push(tagArr[i]);
    }
    uniqTags.push(tagArr[tagArr.length - 1]);
    if (tagArr.length > uniqTags.length) {
        WScript.StdErr.WriteLine(
            'same tag occurred more than once in list of tags');
        WSH.Quit(1);
    }
    return tagArr;
} // valTags

// validate list of categories
function valCats(catList) {
    switch (true) {
        case !(/^[a-zA-Z0-9 \t,&_-]+$/.test(catList)):
            WScript.StdErr.WriteLine(
                'list of categories may contain the following characters:\n' +
                'a-z, A-Z, 0-9, space, tab, comma, &, -, and _');
            WSH.Quit(1);
            break;
        case /^(?:[ \t]+)?,|,(?:[ \t]+)?$/g.test(catList):
            WScript.StdErr.WriteLine(
                'leading/trailing commas in list of categories');
            WSH.Quit(1);
            break;
        case /,(?:[ \t]+)?,/g.test(catList):
            WScript.StdErr.WriteLine(
                'two or more consecutive commas found in list of categories'
            );
            WSH.Quit(1);
            break;
        case /,(?:[ \t]+)?[&_-]|[&_-](?:[ \t]+)?,/.test(',' + catList + ','):
            WScript.StdErr.WriteLine(
                'categories may not begin or end with &, _, or -');
            WSH.Quit(1);
            break;
        case /[&_-]{2,}/.test(catList):
            WScript.StdErr.WriteLine(
                'categories may not contain two or more consecutive &, _, or - chars'
            );
            WSH.Quit(1);
            break;
        default:
            break;
    } // switch
    var catArr = catList.split(','),
        i;
    for (i = 0; i < catArr.length; i++) {
        catArr[i] = catArr[i].replace(/^[ \t]+|[ \t]+$/g, '')
            .replace(/[ \t]+/g, ' ');
    }
    catArr = catArr.sort();
    var uniqCats = [];
    for (i = 0; i < catArr.length - 1; i++) {
        if (catArr[i].toLowerCase() != catArr[i + 1].toLowerCase()) {
            uniqCats.push(catArr[i]);
        }
    }
    uniqCats.push(catArr[catArr.length - 1]);
    if (catArr.length > uniqCats.length) {
        WScript.StdErr.WriteLine(
            'same category occurred more than once in list of categories');
        WSH.Quit(1);
    }
    return catArr;
} // valCats

// main program
// objects and variables:
var args = WScript.Arguments,
    fso = WScript.CreateObject('Scripting.FileSystemObject'),
    WshShell = WScript.CreateObject('WScript.Shell'),
    xmlObj = WScript.CreateObject('MSXML2.XMLHTTP'),
    cfgFile = 'blog.cfg',
    logFile = 'posts.log',
    logObj,
    cfgLines = '',
    mkdLines = '',
    errFlag = 1,
    lineNo = 0,
    mkdFile = args(0).replace(/^.+\\(.+)$/, '$1');
// read in config file
cfgLines = readFile(cfgFile);
// strip trailing whitespace and ensure 1 newline at eof
cfgLines = cfgLines.replace(/[ \t]+\n/g, '\n').replace(/\n*$/, '\n');
cfgHash = valHdrs(cfgFile, cfgLines);
var req = 0;
for (key in cfgHash) {
    switch (key) {
        case 'username':
        case 'password':
        case 'endpoint':
            req++;
            break;
        default:
            WSH.StdErr.WriteLine('unknown key: ' + key);
            WSH.Quit(1);
            break;
    } // switch
} // for
if (req < 3) {
    WSH.StdErr.WriteLine(
        'one or more required entries missing from config file');
    WSH.Quit(1);
}
// read in markdown file
mkdLines = readFile(mkdFile);
// strip trailing whitespace and trailing blank lines
mkdLines = mkdLines.replace(/[ \t]+\n/g, '\n').replace(/\n+$/, '');
// hack to detect empty body
mkdLines += '\n\n';
mkdHash = valHdrs(mkdFile, mkdLines);
var bodyLines = mkdLines.replace(/^---\n(?:.+\n)+---\n/, '');
bodyLines = bodyLines.replace(/^\n+|\n+$/g, '');
if (bodyLines == '') {
    WSH.StdErr.Writeline('missing body in input file');
    WSH.Quit(1);
}
key = '', req = 0;
for (key in mkdHash) {
    switch (key) {
        case 'title':
        case 'date':
        case 'categories':
            req++;
            break;
        case 'author':
        case 'status':
        case 'comments':
        case 'pingbacks':
        case 'sticky':
        case 'format':
        case 'tags':
            break;
        default:
            WSH.StdErr.WriteLine('unknown key: ' + key);
            WSH.Quit(1);
            break;
    } //switch
} // for
if (req < 3) {
    WSH.StdErr.WriteLine('one or more required entries missing from "' +
        mkdFile + '"');
    WSH.Quit(1);
}
// add md5 hash of body of markdown file
mkdHash['md5'] = MD5(bodyLines);
// process log file
var newPost = false,
    editPost = false,
    maxLogSize = Math.pow(2, 30),
    warnLogSize = Math.pow(2, 26) * 15,
    logSize = fso.GetFile(logFile).size,
    lines = '',
    postsArr = [],
    mkdLen = 0,
    i = 0,
    j = 0,
    entHash = {};
if (logSize < maxLogSize && logSize > warnLogSize) {
    WSH.StdErr.WriteLine('WARNING: "' + logFile +
        '" is becoming unmanageably large');
} else if (logSize > maxLogSize) {
    WSH.StdErr.WriteLine('"' + logFile + '" is too large to process');
    WSH.Quit(1);
} // if
// open log file and slurp up entire contents
logObj = fso.OpenTextFile(logFile, 1, false, 0);
lines = logObj.Read(logSize);
logObj.Close();
// zap CRs and leading/trailing newlines
lines = lines.replace(/\r/g, '').replace(/^\n+|\n+$/g, '');
// split lines into array of entries
postsArr = lines.split('\n\n');
// search entries for filename
mkdLen = mkdFile.length;
if (postsArr[0]) {
    while (i < postsArr.length) {
        if (postsArr[i].substr(10, mkdLen) == mkdFile) break;
        i++;
    } // while
} // if
// must be a new post if no entry found
if (i == postsArr.length || !postsArr[0]) {
    newPost = true;
}
// only do following if not new post
if (!newPost) {
    // split entry into hash of key-value pairs
    var entArr = postsArr[i].split('\n');
    while (j < entArr.length) {
        key = entArr[j].match(/^(.+?):/)[1];
        entHash[key] = entArr[j].match(/^.+?:[ \t]+(.+)$/)[1];
        j++;
    } // while
    // edit post if log file entry not same as infile's hdr block
    for (key in mkdHash) {
        if (entHash[key] === undefined || mkdHash[key] != entHash[key]) {
            editPost = true;
            break;
        } // if 2
    } // for
} // if 1
var xmlStr = '<?xml version="1.0" encoding="US-ASCII"?>\n',
    updHash = {};
if (editPost) {
    updHash = mkdHash;
    for (key in entHash) {
        if (updHash[key] === undefined) {
            updHash[key] = entHash[key];
        } // if 2
    } // for
    xmlStr += '<methodCall><methodName>wp.editPost</methodName>\n' +
        '<params><param><value>0</value></param>\n' +
        '<param><value>' + cfgHash['username'] + '</value></param>\n' +
        '<param><value>' + Entify(cfgHash['password']) + '</value></param>\n' +
        '<param><value>' + updHash['postid'] + '</value></param>\n' +
        '<param><value><struct>\n';
} else if (!newPost) {
    WSH.StdErr.WriteLine('no changes detected since last update');
    WSH.Quit(0);
} // if 1
if (newPost) {
    updHash = mkdHash;
    xmlStr += '<methodCall><methodName>wp.newPost</methodName>\n' +
        '<params><param><value>0</value></param>\n' +
        '<param><value>' + cfgHash['username'] + '</value></param>\n' +
        '<param><value>' + Entify(cfgHash['password']) + '</value></param>\n' +
        '<param><value><struct>\n';
} // if
var tcFlag = false;
for (key in updHash) {
    switch (key) {
        case 'filename':
        case 'postid':
        case 'author':
        case 'utc':
        case 'created':
        case 'updated':
        case 'editions':
            break;
        case 'md5':
            if (newPost || (editPost && mkdHash['md5'] != entHash['md5'])) {
                xmlStr += Memberise('post_content', Entify(mkd2HTML(mkdFile)));
            }
            break;
        case 'title':
            xmlStr += Memberise('post_title', Entify(updHash[key]));
            break;
        case 'date':
            var dtStr = updHash[key].replace(/[ \t]+/g, ' ').toUpperCase();
            var ltStr = valDateTime(dtStr);
            var gmtStr = ldt2GMT(ltStr);
            xmlStr += Memberise('post_date', '<dateTime.iso8601>' + ltStr +
                '</dateTime.iso8601>');
            xmlStr += Memberise('post_date_gmt', '<dateTime.iso8601>' + gmtStr +
                '</dateTime.iso8601>');
            break;
        case 'status':
            if (!(/^(?:draft|future|pending|private|publish|trash)$/.test(
                    updHash[key]))) {
                WSH.StdErr.WriteLine('unsupported value in "' + key +
                    '" header');
                WSH.Quit(1);
            } else {
                xmlStr += Memberise('post_status', updHash[key]);
            }
            break;
        case 'comments':
        case 'pingbacks':
            if (key == 'comments') {
                var hdrName = 'comment_status';
            } else {
                var hdrName = 'ping_status';
            }
            if (updHash[key] != 'open' && updHash[key] != 'closed') {
                WSH.StdErr.WriteLine('"' + key +
                    '" must have a value of either "open" or "closed"');
                WSH.Quit(1);
            } else {
                xmlStr += Memberise(hdrName, updHash[key]);
            }
            break;
        case 'sticky':
            if (updHash[key] != '0' && updHash[key] != '1') {
                WSH.StdErr.WriteLine('"' + key +
                    '" must have a value of either "0" (default) or "1"');
                WSH.Quit(1);
            } else {
                xmlStr += Memberise(key, updHash[key]);
            }
            break;
        case 'format':
            if (!(
                    /^(?:standard|aside|audio|chat|gallery|image|link|quote|status|video)$/
                    .test(updHash[key]))) {
                WSH.StdErr.WriteLine('unsupported value in "' + key +
                    '" header');
                WSH.Quit(1);
            } else {
                xmlStr += Memberise('post_format', updHash[key]);
            }
            break;
        case 'categories':
            tcFlag = true;
            var catsArr = valCats(updHash[key]),
                index,
                catsStr = '<member><name>category</name><value><array><data>\n';
            for (index in catsArr) {
                catsStr += '<value>' + Entify(catsArr[index]) + '</value>\n';
            }
            catsStr += '</data></array></value></member>\n';
            break;
        case 'tags':
            tcFlag = true;
            var tagsArr = valTags(updHash[key]),
                index,
                tagsStr = '<member><name>post_tag</name><value><array><data>\n';
            for (index in tagsArr) {
                tagsStr += '<value>' + Entify(tagsArr[index]) + '</value>\n';
            }
            tagsStr += '</data></array></value></member>\n';
            break;
        default:
            WSH.Echo('unknown key: ' + key);
            WSH.Quit(1);
            break;
    } // switch
} // for
if (tcFlag) {
    xmlStr += '<member><name>terms_names</name><value><struct>\n';
    if (catsStr) xmlStr += catsStr;
    if (tagsStr) xmlStr += tagsStr;
    xmlStr += '</struct></value></member>\n';
}
xmlStr += '</struct></value></param></params></methodCall>\n';
xmlObj.Open('POST', cfgHash['endpoint'], false);
xmlObj.setRequestHeader('Content-Type', 'text/xml');
xmlObj.send(xmlStr);
var status = xmlObj.status;
if (status != 200) {
    WScript.StdErr.WriteLine('an error occurred while posting to blog:\n' +
        xmlObj.status + ': ' + xmlObj.statusText + '\n' +
        xmlObj.responseText.match(/<string>(.+?)<\/string>/i)[1]);
    WSH.Quit(1);
} // if
if (newPost) {
    WScript.StdErr.WriteLine('new post created');
} else {
    WScript.StdErr.WriteLine('existing post updated');
} // if
var now = new Date();
updHash['updated'] = now.getUTCFullYear() + '/' + padStr(now.getUTCMonth() + 1) +
    '/' +
    padStr(now.getUTCDate()) + ' ' + padStr(now.getUTCHours()) + ':' +
    padStr(now.getUTCMinutes()) + ':' + padStr(now.getUTCSeconds()) + ' UTC';
if (newPost) {
    updHash['filename'] = mkdFile;
    updHash['postid'] = xmlObj.responseText.match(/<string>(.+?)<\/string>/i)[1];
    updHash['utc'] = gmtStr.replace(/\D+/g, '');
    updHash['created'] = updHash['updated'];
    updHash['editions'] = 1;
} else {
    updHash['editions']++;
} // if
var ordArr = ['filename', 'postid', 'title', 'author', 'date', 'utc', 'status',
    'comments', 'pingbacks', 'sticky', 'format', 'categories', 'tags',
    'created',
    'updated', 'editions'
];
postsArr[i] = '';
for (j = 0; j < ordArr.length; j++) {
    if (updHash[ordArr[j]] != null) {
        postsArr[i] += ordArr[j] + ': ' + updHash[ordArr[j]] + '\n';
    } // if
} // for
postsArr[i] += 'md5: ' + updHash['md5'];
// sort posts array based on utc date of each entry
postsArr.sort(function(a, b) {
    if (a.match(/\nutc: (\d+)\n/)[1] < b.match(/\nutc: (\d+)\n/)[1])
        return -1;
    if (a.match(/\nutc: (\d+)\n/)[1] > b.match(/\nutc: (\d+)\n/)[1])
        return 1;
    return 0;
}); // sort
logObj = fso.OpenTextFile(logFile, 2, false, 0);
logObj.Write(postsArr.join('\n\n') + '\n');
logObj.Close();
WSH.Quit(0);
