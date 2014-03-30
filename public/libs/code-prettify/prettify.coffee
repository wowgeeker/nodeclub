q = null
window.PR_SHOULD_USE_CONTINUATION = not 0
(->
  L = (a) ->
    m = (a) ->
      f = a.charCodeAt(0)
      return f  if f isnt 92
      b = a.charAt(1)
      (if (f = r[b]) then f else (if "0" <= b and b <= "7" then parseInt(a.substring(1), 8) else (if b is "u" or b is "x" then parseInt(a.substring(2), 16) else a.charCodeAt(1))))
    e = (a) ->
      return ((if a < 16 then "\\x0" else "\\x")) + a.toString(16)  if a < 32
      a = String.fromCharCode(a)
      a = "\\" + a  if a is "\\" or a is "-" or a is "[" or a is "]"
      a
    h = (a) ->
      f = a.substring(1, a.length - 1).match(/\\u[\dA-Fa-f]{4}|\\x[\dA-Fa-f]{2}|\\[0-3][0-7]{0,2}|\\[0-7]{1,2}|\\[\S\s]|[^\\]/g)
      a = []
      b = []
      o = f[0] is "^"
      c = (if o then 1 else 0)
      i = f.length

      while c < i
        j = f[c]
        if /\\[bdsw]/i.test(j)
          a.push j
        else
          j = m(j)
          d = undefined
          (if c + 2 < i and "-" is f[c + 1] then (d = m(f[c + 2])
          c += 2
          ) else d = j)
          b.push [
            j
            d
          ]
          d < 65 or j > 122 or (d < 65 or j > 90 or b.push([
            Math.max(65, j) | 32
            Math.min(d, 90) | 32
          ])
          d < 97 or j > 122 or b.push([
            Math.max(97, j) & -33
            Math.min(d, 122) & -33
          ])
          )
        ++c
      b.sort (a, f) ->
        a[0] - f[0] or f[1] - a[1]

      f = []
      j = [
        NaN
        NaN
      ]
      c = 0
      while c < b.length
        i = b[c]
        (if i[0] <= j[1] + 1 then j[1] = Math.max(j[1], i[1]) else f.push(j = i))
        ++c
      b = ["["]
      o and b.push("^")
      b.push.apply b, a
      c = 0
      while c < f.length
        i = f[c]
        b.push(e(i[0]))
        i[1] > i[0] and (i[1] + 1 > i[0] and b.push("-")
        b.push(e(i[1]))
        )
        ++c
      b.push "]"
      b.join ""
    y = (a) ->
      f = a.source.match(/\[(?:[^\\\]]|\\[\S\s])*]|\\u[\dA-Fa-f]{4}|\\x[\dA-Fa-f]{2}|\\\d+|\\[^\dux]|\(\?[!:=]|[()^]|[^()[\\^]+/g)
      b = f.length
      d = []
      c = 0
      i = 0

      while c < b
        j = f[c]
        (if j is "(" then ++i else "\\" is j.charAt(0) and (j = +j.substring(1)) and j <= i and (d[j] = -1))
        ++c
      c = 1
      while c < d.length
        -1 is d[c] and (d[c] = ++t)
        ++c
      i = c = 0
      while c < b
        j = f[c]
        (if j is "(" then (++i
        d[i] is undefined and (f[c] = "(?:")
        ) else "\\" is j.charAt(0) and (j = +j.substring(1)) and j <= i and (f[c] = "\\" + d[i]))
        ++c
      i = c = 0
      while c < b
        "^" is f[c] and "^" isnt f[c + 1] and (f[c] = "")
        ++c
      if a.ignoreCase and s
        c = 0
        while c < b
          j = f[c]
          a = j.charAt(0)
          (if j.length >= 2 and a is "[" then f[c] = h(j) else a isnt "\\" and (f[c] = j.replace(/[A-Za-z]/g, (a) ->
            a = a.charCodeAt(0)
            "[" + String.fromCharCode(a & -33, a | 32) + "]"
          )))
          ++c
      f.join ""
    t = 0
    s = not 1
    l = not 1
    p = 0
    d = a.length

    while p < d
      g = a[p]
      if g.ignoreCase
        l = not 0
      else if /[a-z]/i.test(g.source.replace(/\\u[\da-f]{4}|\\x[\da-f]{2}|\\[^UXux]/g, ""))
        s = not 0
        l = not 1
        break
      ++p
    r =
      b: 8
      t: 9
      n: 10
      v: 11
      f: 12
      r: 13

    n = []
    p = 0
    d = a.length

    while p < d
      g = a[p]
      throw Error("" + g)  if g.global or g.multiline
      n.push "(?:" + y(g) + ")"
      ++p
    RegExp n.join("|"), (if l then "gi" else "g")
  M = (a) ->
    m = (a) ->
      switch a.nodeType
        when 1
          break  if e.test(a.className)
          g = a.firstChild

          while g
            m g
            g = g.nextSibling
          g = a.nodeName
          if "BR" is g or "LI" is g
            h[s] = "\n"
            t[s << 1] = y++
            t[s++ << 1 | 1] = a
        when 3, 4
          g = a.nodeValue
          g.length and (g = (if p then g.replace(/\r\n?/g, "\n") else g.replace(/[\t\n\r ]+/g, " "))
          h[s] = g
          t[s << 1] = y
          y += g.length
          t[s++ << 1 | 1] = a
          )
      return
    e = /(?:^|\s)nocode(?:\s|$)/
    h = []
    y = 0
    t = []
    s = 0
    l = undefined
    (if a.currentStyle then l = a.currentStyle.whiteSpace else window.getComputedStyle and (l = document.defaultView.getComputedStyle(a, q).getPropertyValue("white-space")))
    p = l and "pre" is l.substring(0, 3)
    m a
    a: h.join("").replace(/\n$/, "")
    c: t
  B = (a, m, e, h) ->
    m and (a =
      a: m
      d: a

    e(a)
    h.push.apply(h, a.e)
    )
    return
  x = (a, m) ->
    e = (a) ->
      l = a.d
      p = [
        l
        "pln"
      ]
      d = 0
      g = a.a.match(y) or []
      r = {}
      n = 0
      z = g.length

      while n < z
        f = g[n]
        b = r[f]
        o = undefined
        c = undefined
        if typeof b is "string"
          c = not 1
        else
          i = h[f.charAt(0)]
          if i
            o = f.match(i[1])
            b = i[0]
          else
            c = 0
            while c < t
              if i = m[c]
              o = f.match(i[1])
                b = i[0]
                break
              ++c
            o or (b = "pln")
          if (c = b.length >= 5 and "lang-" is b.substring(0, 5)) and not (o and typeof o[1] is "string")
            c = not 1
            b = "src"
          c or (r[f] = b)
        i = d
        d += f.length
        if c
          c = o[1]
          j = f.indexOf(c)
          k = j + c.length
          o[2] and (k = f.length - o[2].length
          j = k - c.length
          )
          b = b.substring(5)
          B l + i, f.substring(0, j), e, p
          B l + i + j, c, C(b, c), p
          B l + i + k, f.substring(k), e, p
        else
          p.push l + i, b
        ++n
      a.e = p
      return
    h = {}
    y = undefined
    (->
      e = a.concat(m)
      l = []
      p = {}
      d = 0
      g = e.length

      while d < g
        r = e[d]
        n = r[3]
        if n
          k = n.length

          while --k >= 0
            h[n.charAt(k)] = r
        r = r[1]
        n = "" + r
        p.hasOwnProperty(n) or (l.push(r)
        p[n] = q
        )
        ++d
      l.push /[\S\s]/
      y = L(l)
      return
    )()
    t = m.length
    e
  u = (a) ->
    m = []
    e = []
    (if a.tripleQuotedStrings then m.push([
      "str"
      /^(?:'''(?:[^'\\]|\\[\S\s]|''?(?=[^']))*(?:'''|$)|"""(?:[^"\\]|\\[\S\s]|""?(?=[^"]))*(?:"""|$)|'(?:[^'\\]|\\[\S\s])*(?:'|$)|"(?:[^"\\]|\\[\S\s])*(?:"|$))/
      q
      "'\""
    ]) else (if a.multiLineStrings then m.push([
      "str"
      /^(?:'(?:[^'\\]|\\[\S\s])*(?:'|$)|"(?:[^"\\]|\\[\S\s])*(?:"|$)|`(?:[^\\`]|\\[\S\s])*(?:`|$))/
      q
      "'\"`"
    ]) else m.push([
      "str"
      /^(?:'(?:[^\n\r'\\]|\\.)*(?:'|$)|"(?:[^\n\r"\\]|\\.)*(?:"|$))/
      q
      "\"'"
    ])))
    a.verbatimStrings and e.push([
      "str"
      /^@"(?:[^"]|"")*(?:"|$)/
      q
    ])
    h = a.hashComments
    h and ((if a.cStyleComments then ((if h > 1 then m.push([
      "com"
      /^#(?:##(?:[^#]|#(?!##))*(?:###|$)|.*)/
      q
      "#"
    ]) else m.push([
      "com"
      /^#(?:(?:define|elif|else|endif|error|ifdef|include|ifndef|line|pragma|undef|warning)\b|[^\n\r]*)/
      q
      "#"
    ]))
    e.push([
      "str"
      /^<(?:(?:(?:\.\.\/)*|\/?)(?:[\w-]+(?:\/[\w-]+)+)?[\w-]+\.h|[a-z]\w*)>/
      q
    ])
    ) else m.push([
      "com"
      /^#[^\n\r]*/
      q
      "#"
    ])))
    a.cStyleComments and (e.push([
      "com"
      /^\/\/[^\n\r]*/
      q
    ])
    e.push([
      "com"
      /^\/\*[\S\s]*?(?:\*\/|$)/
      q
    ])
    )
    a.regexLiterals and e.push([
      "lang-regex"
      /^(?:^^\.?|[!+-]|!=|!==|#|%|%=|&|&&|&&=|&=|\(|\*|\*=|\+=|,|-=|->|\/|\/=|:|::|;|<|<<|<<=|<=|=|==|===|>|>=|>>|>>=|>>>|>>>=|[?@[^]|\^=|\^\^|\^\^=|{|\||\|=|\|\||\|\|=|~|break|case|continue|delete|do|else|finally|instanceof|return|throw|try|typeof)\s*(\/(?=[^*/])(?:[^/[\\]|\\[\S\s]|\[(?:[^\\\]]|\\[\S\s])*(?:]|$))+\/)/
    ])
    (h = a.types) and e.push([
      "typ"
      h
    ])
    a = ("" + a.keywords).replace(/^ | $/g, "")
    a.length and e.push([
      "kwd"
      RegExp("^(?:" + a.replace(/[\s,]+/g, "|") + ")\\b")
      q
    ])
    m.push [
      "pln"
      /^\s+/
      q
      " \r\n\t "
    ]
    e.push [
      "lit"
      /^@[$_a-z][\w$@]*/i
      q
    ], [
      "typ"
      /^(?:[@_]?[A-Z]+[a-z][\w$@]*|\w+_t\b)/
      q
    ], [
      "pln"
      /^[$_a-z][\w$@]*/i
      q
    ], [
      "lit"
      /^(?:0x[\da-f]+|(?:\d(?:_\d+)*\d*(?:\.\d*)?|\.\d\+)(?:e[+-]?\d+)?)[a-z]*/i
      q
      "0123456789"
    ], [
      "pln"
      /^\\[\S\s]?/
      q
    ], [
      "pun"
      /^.[^\s\w"-$'./@\\`]*/
      q
    ]
    x m, e
  D = (a, m) ->
    e = (a) ->
      switch a.nodeType
        when 1
          break  if k.test(a.className)
          if "BR" is a.nodeName
            h(a)
            a.parentNode and a.parentNode.removeChild(a)
          else
            a = a.firstChild
            while a
              e a
              a = a.nextSibling
        when 3, 4
          if p
            b = a.nodeValue
            d = b.match(t)
            if d
              c = b.substring(0, d.index)
              a.nodeValue = c
              (b = b.substring(d.index + d[0].length)) and a.parentNode.insertBefore(s.createTextNode(b), a.nextSibling)
              h a
              c or a.parentNode.removeChild(a)
      return
    h = (a) ->
      b = (a, d) ->
        e = (if d then a.cloneNode(not 1) else a)
        f = a.parentNode
        if f
          f = b(f, 1)
          g = a.nextSibling
          f.appendChild e
          h = g

          while h
            g = h.nextSibling
            f.appendChild(h)
            h = g
        e
      while not a.nextSibling
        return  if a = a.parentNode
        not a
      a = b(a.nextSibling, 0)
      e = undefined

      while (e = a.parentNode) and e.nodeType is 1
        a = e
      d.push a
      return
    k = /(?:^|\s)nocode(?:\s|$)/
    t = /\r\n?|\n/
    s = a.ownerDocument
    l = undefined
    (if a.currentStyle then l = a.currentStyle.whiteSpace else window.getComputedStyle and (l = s.defaultView.getComputedStyle(a, q).getPropertyValue("white-space")))
    p = l and "pre" is l.substring(0, 3)
    l = s.createElement("LI")
    while a.firstChild
      l.appendChild a.firstChild
    d = [l]
    g = 0

    while g < d.length
      e d[g]
      ++g
    m is (m | 0) and d[0].setAttribute("value", m)
    r = s.createElement("OL")
    r.className = "linenums"
    n = Math.max(0, m - 1 | 0) or 0
    g = 0
    z = d.length

    while g < z
      l = d[g]
      l.className = "L" + (g + n) % 10
      l.firstChild or l.appendChild(s.createTextNode(" "))
      r.appendChild(l)
      ++g
    a.appendChild r
    return
  k = (a, m) ->
    e = m.length

    while --e >= 0
      h = m[e]
      (if A.hasOwnProperty(h) then window.console and console.warn("cannot override language handler %s", h) else A[h] = a)
    return
  C = (a, m) ->
    a = (if /^\s*</.test(m) then "default-markup" else "default-code")  if not a or not A.hasOwnProperty(a)
    A[a]
  E = (a) ->
    m = a.g
    try
      e = M(a.h)
      h = e.a
      a.a = h
      a.c = e.c
      a.d = 0
      C(m, h) a
      k = /\bMSIE\b/.test(navigator.userAgent)
      m = /\n/g
      t = a.a
      s = t.length
      e = 0
      l = a.c
      p = l.length
      h = 0
      d = a.e
      g = d.length
      a = 0
      d[g] = s
      r = undefined
      n = undefined
      n = r = 0
      while n < g
        (if d[n] isnt d[n + 2] then (d[r++] = d[n++]
        d[r++] = d[n++]
        ) else n += 2)
      g = r
      n = r = 0
      while n < g
        z = d[n]
        f = d[n + 1]
        b = n + 2

        while b + 2 <= g and d[b + 1] is f
          b += 2
        d[r++] = z
        d[r++] = f
        n = b
      d.length = r
      while h < p
        o = l[h + 2] or s
        c = d[a + 2] or s
        b = Math.min(o, c)
        i = l[h + 1]
        j = undefined
        if i.nodeType isnt 1 and (j = t.substring(e, b))
          k and (j = j.replace(m, "\r"))
          i.nodeValue = j
          u = i.ownerDocument
          v = u.createElement("SPAN")
          v.className = d[a + 1]
          x = i.parentNode
          x.replaceChild v, i
          v.appendChild i
          e < o and (l[h + 1] = i = u.createTextNode(t.substring(b, o))
          x.insertBefore(i, v.nextSibling)
          )
        e = b
        e >= o and (h += 2)
        e >= c and (a += 2)
    catch w
      "console" of window and console.log((if w and w.stack then w.stack else w))
    return
  v = ["break,continue,do,else,for,if,return,while"]
  w = [
    [
      v
      "auto,case,char,const,default,double,enum,extern,float,goto,int,long,register,short,signed,sizeof,static,struct,switch,typedef,union,unsigned,void,volatile"
    ]
    "catch,class,delete,false,import,new,operator,private,protected,public,this,throw,true,try,typeof"
  ]
  F = [
    w
    "alignof,align_union,asm,axiom,bool,concept,concept_map,const_cast,constexpr,decltype,dynamic_cast,explicit,export,friend,inline,late_check,mutable,namespace,nullptr,reinterpret_cast,static_assert,static_cast,template,typeid,typename,using,virtual,where"
  ]
  G = [
    w
    "abstract,boolean,byte,extends,final,finally,implements,import,instanceof,null,native,package,strictfp,super,synchronized,throws,transient"
  ]
  H = [
    G
    "as,base,by,checked,decimal,delegate,descending,dynamic,event,fixed,foreach,from,group,implicit,in,interface,internal,into,is,lock,object,out,override,orderby,params,partial,readonly,ref,sbyte,sealed,stackalloc,string,select,uint,ulong,unchecked,unsafe,ushort,var"
  ]
  w = [
    w
    "debugger,eval,export,function,get,null,set,undefined,var,with,Infinity,NaN"
  ]
  I = [
    v
    "and,as,assert,class,def,del,elif,except,exec,finally,from,global,import,in,is,lambda,nonlocal,not,or,pass,print,raise,try,with,yield,False,True,None"
  ]
  J = [
    v
    "alias,and,begin,case,class,def,defined,elsif,end,ensure,false,in,module,next,nil,not,or,redo,rescue,retry,self,super,then,true,undef,unless,until,when,yield,BEGIN,END"
  ]
  v = [
    v
    "case,done,elif,esac,eval,fi,function,in,local,set,then,until"
  ]
  K = /^(DIR|FILE|vector|(de|priority_)?queue|list|stack|(const_)?iterator|(multi)?(set|map)|bitset|u?(int|float)\d*)/
  N = /\S/
  O = u(
    keywords: [
      F
      H
      w
      "caller,delete,die,do,dump,elsif,eval,exit,foreach,for,goto,if,import,last,local,my,next,no,our,print,package,redo,require,sub,undef,unless,until,use,wantarray,while,BEGIN,END" + I
      J
      v
    ]
    hashComments: not 0
    cStyleComments: not 0
    multiLineStrings: not 0
    regexLiterals: not 0
  )
  A = {}
  k O, ["default-code"]
  k x([], [
    [
      "pln"
      /^[^<?]+/
    ]
    [
      "dec"
      /^<!\w[^>]*(?:>|$)/
    ]
    [
      "com"
      /^<\!--[\S\s]*?(?:--\>|$)/
    ]
    [
      "lang-"
      /^<\?([\S\s]+?)(?:\?>|$)/
    ]
    [
      "lang-"
      /^<%([\S\s]+?)(?:%>|$)/
    ]
    [
      "pun"
      /^(?:<[%?]|[%?]>)/
    ]
    [
      "lang-"
      /^<xmp\b[^>]*>([\S\s]+?)<\/xmp\b[^>]*>/i
    ]
    [
      "lang-js"
      /^<script\b[^>]*>([\S\s]*?)(<\/script\b[^>]*>)/i
    ]
    [
      "lang-css"
      /^<style\b[^>]*>([\S\s]*?)(<\/style\b[^>]*>)/i
    ]
    [
      "lang-in.tag"
      /^(<\/?[a-z][^<>]*>)/i
    ]
  ]), [
    "default-markup"
    "htm"
    "html"
    "mxml"
    "xhtml"
    "xml"
    "xsl"
  ]
  k x([
    [
      "pln"
      /^\s+/
      q
      " \t\r\n"
    ]
    [
      "atv"
      /^(?:"[^"]*"?|'[^']*'?)/
      q
      "\"'"
    ]
  ], [
    [
      "tag"
      /^^<\/?[a-z](?:[\w-.:]*\w)?|\/?>$/i
    ]
    [
      "atn"
      /^(?!style[\s=]|on)[a-z](?:[\w:-]*\w)?/i
    ]
    [
      "lang-uq.val"
      /^=\s*([^\s"'>]*(?:[^\s"'/>]|\/(?=\s)))/
    ]
    [
      "pun"
      /^[/<->]+/
    ]
    [
      "lang-js"
      /^on\w+\s*=\s*"([^"]+)"/i
    ]
    [
      "lang-js"
      /^on\w+\s*=\s*'([^']+)'/i
    ]
    [
      "lang-js"
      /^on\w+\s*=\s*([^\s"'>]+)/i
    ]
    [
      "lang-css"
      /^style\s*=\s*"([^"]+)"/i
    ]
    [
      "lang-css"
      /^style\s*=\s*'([^']+)'/i
    ]
    [
      "lang-css"
      /^style\s*=\s*([^\s"'>]+)/i
    ]
  ]), ["in.tag"]
  k x([], [[
    "atv"
    /^[\S\s]+/
  ]]), ["uq.val"]
  k u(
    keywords: F
    hashComments: not 0
    cStyleComments: not 0
    types: K
  ), [
    "c"
    "cc"
    "cpp"
    "cxx"
    "cyc"
    "m"
  ]
  k u(keywords: "null,true,false"), ["json"]
  k u(
    keywords: H
    hashComments: not 0
    cStyleComments: not 0
    verbatimStrings: not 0
    types: K
  ), ["cs"]
  k u(
    keywords: G
    cStyleComments: not 0
  ), ["java"]
  k u(
    keywords: v
    hashComments: not 0
    multiLineStrings: not 0
  ), [
    "bsh"
    "csh"
    "sh"
  ]
  k u(
    keywords: I
    hashComments: not 0
    multiLineStrings: not 0
    tripleQuotedStrings: not 0
  ), [
    "cv"
    "py"
  ]
  k u(
    keywords: "caller,delete,die,do,dump,elsif,eval,exit,foreach,for,goto,if,import,last,local,my,next,no,our,print,package,redo,require,sub,undef,unless,until,use,wantarray,while,BEGIN,END"
    hashComments: not 0
    multiLineStrings: not 0
    regexLiterals: not 0
  ), [
    "perl"
    "pl"
    "pm"
  ]
  k u(
    keywords: J
    hashComments: not 0
    multiLineStrings: not 0
    regexLiterals: not 0
  ), ["rb"]
  k u(
    keywords: w
    cStyleComments: not 0
    regexLiterals: not 0
  ), ["js"]
  k u(
    keywords: "all,and,by,catch,class,else,extends,false,finally,for,if,in,is,isnt,loop,new,no,not,null,of,off,on,or,return,super,then,true,try,unless,until,when,while,yes"
    hashComments: 3
    cStyleComments: not 0
    multilineStrings: not 0
    tripleQuotedStrings: not 0
    regexLiterals: not 0
  ), ["coffee"]
  k x([], [[
    "str"
    /^[\S\s]+/
  ]]), ["regex"]
  window.prettyPrintOne = (a, m, e) ->
    h = document.createElement("PRE")
    h.innerHTML = a
    e and D(h, e)
    E
      g: m
      i: e
      h: h

    h.innerHTML

  window.prettyPrint = (a) ->
    m = ->
      e = (if window.PR_SHOULD_USE_CONTINUATION then l.now() + 250 else Infinity)

      while p < h.length and l.now() < e
        n = h[p]
        k = n.className
        if k.indexOf("prettyprint") >= 0
          k = k.match(g)
          f = undefined
          b = undefined
          if b = not k
            b = n
            o = undefined
            c = b.firstChild

            while c
              i = c.nodeType
              o = (if i is 1 then (if o then b else c) else (if i is 3 then (if N.test(c.nodeValue) then b else o) else o))
              c = c.nextSibling
            b = (f = (if o is b then undefined else o)) and "CODE" is f.tagName
          b and (k = f.className.match(g))
          k and (k = k[1])
          b = not 1
          o = n.parentNode
          while o
            if (o.tagName is "pre" or o.tagName is "code" or o.tagName is "xmp") and o.className and o.className.indexOf("prettyprint") >= 0
              b = not 0
              break
            o = o.parentNode
          b or ((b = (if (b = n.className.match(/\blinenums\b(?::(\d+))?/)) then (if b[1] and b[1].length then +b[1] else not 0) else not 1)) and D(n, b)
          d =
            g: k
            h: n
            i: b

          E(d)
          )
        p++
      (if p < h.length then setTimeout(m, 250) else a and a())
      return
    e = [
      document.getElementsByTagName("pre")
      document.getElementsByTagName("code")
      document.getElementsByTagName("xmp")
    ]
    h = []
    k = 0

    while k < e.length
      t = 0
      s = e[k].length

      while t < s
        h.push e[k][t]
        ++t
      ++k
    e = q
    l = Date
    l.now or (l = now: ->
      +new Date
    )
    p = 0
    d = undefined
    g = /\blang(?:uage)?-([\w.]+)(?!\S)/
    m()
    return

  window.PR =
    createSimpleLexer: x
    registerLangHandler: k
    sourceDecorator: u
    PR_ATTRIB_NAME: "atn"
    PR_ATTRIB_VALUE: "atv"
    PR_COMMENT: "com"
    PR_DECLARATION: "dec"
    PR_KEYWORD: "kwd"
    PR_LITERAL: "lit"
    PR_NOCODE: "nocode"
    PR_PLAIN: "pln"
    PR_PUNCTUATION: "pun"
    PR_SOURCE: "src"
    PR_STRING: "str"
    PR_TAG: "tag"
    PR_TYPE: "typ"

  return
)()
