---
title: Using cmdPost
---

## Contents

- [Blog Folders and Special Files][files]
- [Blog Configuration Files][config]
- [Blog Posts][posts]
- [Passing Shortcodes Through to WordPress.com][shortcodes]
- [Preventing Autolinking of Email Addresses and URLs][autolinking]
- [Emoji Support][emojis]
- [cmdPost Usage Example][example]

## Blog Folders and Special Files

Create a folder for your Blog. If you own several blogs, create a separate
folder for each blog. These folders are known as _blog folders_. There are no
restrictions on blog folder names, but it is recommended that the name you
choose has some similarity to the blog associated with it!

Your blog folder is the location where blog posts are stored in the form of
markdown files. Each blog folder must contain a `blog.cfg` file ([described
below][config]).

cmdPost also automatically creates and updates a hidden file called `posts.log`,
which is used to keep track of changes to the markdown files in your blog
folder. Please do not modify or delete this file.

[back to top][top]

## Blog Configuration Files

When cmdPost is executed from the command line, it first checks for the
existance of a blog configuration file called `blog.cfg` in the current folder.
If the file is not found, the program asks you if you would like to create one.
If you answer no, the program terminates with an error message. If yes, the file
is created and the program continues.

Blog configuration files contain WordPress.com username, password, and
[XML RPC Endpoint][XmlRpcEndpoint] information necessary for cmdPost to
function. A correctly formatted `blog.cfg` file must be present in every blog
folder.

You must manually edit `blog.cfg` files, and make sure they conform to the
format of this example:

```
username: wordpressdotcomusername
password: Pa$$word4WordPress.comAccount
endpoint: https://nameofwordpressdotcomsubdomain.wordpress.com/xmlrpc.php
```

Remember to:

1. Replace `wordpressdotcomusername` in the example above with your
  WordPress.com username. Usernames must be between 4 and 50 characters long,
  and may contain digits (`0-9`) and lowercase letters (`a-z`), and must
  include at least 1 letter.

2. Replace `Pa$$word4WordPress.comAccount` in the example above with your
  WordPress.com password. Passwords must be between 6 and 50 characters long,
  and may contain upper and lowercase letters, digits, spaces, and symbols
  such as `$`, `#`, and `@`. A mix of uppercase and lowercase letters, digits,
  and symbols is recommended. Please be aware that `blog.cfg` files store
  passwords as plain text.

3. Replace `nameofwordpressdotcomsubdomain` in the example above with the name
  of your WordPress.com subdomain. The endpoint is the same for all
  WordPress.com blogs, apart from the subdomain (ie, the endpoint begins with
  `https://` and ends with `.wordpress.com/xmlrpc.php` with the WordPress.com
  subdomain name associated with your blog in the middle). Subdomains must be
  between 4 and 50 characters long, may contain lowercase letters, digits, and
  must include at least 1 letter.

A badly formatted `blog.cfg` file will cause cmdPost to terminate with an error
message.

Once you have created the `blog.cfg` file for the current folder, and are
satisfied it is formatted correctly, it is recommended that you make the file
read-only and hidden by entering the following command from the cmd prompt:

```
attrib +r +h blog.cfg
```

Btw, to open the cmd prompt (discouraged in Windows 10 :unamused:), press
**\<Alt+D>** to move to the address bar in **Windows Explorer** (known as **File
Explorer** in Windows 10), type `cmd`, and press **\<Enter>**. And to close the
cmd prompt when you&rsquo;re finished with it, simply enter the `exit` command
in the cmd prompt window.

[back to top][top]

## Blog Posts

cmdPost expects to find your blog posts in a blog folder.
Blog posts  are stored  in markdown files, one post per file.
cmdPost reads in the name of a markdown file from the command line. Filenames
must end with `.md`, `.mkd`, or `.txt`. Files must be in 2 parts:
the header block; and the main content, or _body_.

Header blocks must obey the following rules:

- the header block must be placed at the very start of the markdown file
- the header block begins with a line consisting entirely of 3 dashes (`---`)
- blank lines are not permitted in the header block
- header names without a header value are not permitted (and vice versa)
- each header name and its value must be on a single line
- header names must be between 1 and 20 characters long, begin at the start of
  the line, and consist entirely of lowercase letters (`a-z`)
- header names are separated from their values by a colon (`:`) and 1 or more
  spaces or tabs
- the end of the header block is denoted by a line consisting entirely of 3
  dashes (`---`)
- the header block must be separated from the body of the markdown file by at
  least 1 blank line

The following header names are permitted:

<dl><dt><code>title</code></dt>
<dd>A title is required. The title will be used as a heading in a large font at
the top of your post, so try to keep it to 5 or 6 words (70 characters) at
most.<br /><br /></dd>

<dt><code>author</code></dt>
<dd>Ignored by cmdPost. May be safely omitted.<br /><br /></dd>

<dt><code>date</code></dt>
<dd>A date is required and must be in the format: <code>YYYY/MM/DD hh:mm:ss
UTC[+-][1-12]</code>
<ul><li>Seconds (<code>:ss</code>) and UTC offset (<code>UTC[+-][1-12]</code>)
are optional. If no UTC information is specified, the local system&rsquo;s
timezone is used.</li>
<li>The year must be a 4-digit number between 1000&ndash;9999.</li>
<li>The month must be a 2-digit number between 01&ndash;12.</li>
<li>The date must be a 2-digit number between 01&ndash;31.</li>
<li>The hour must be a 2-digit number between 00&ndash;23.</li>
<li>Minutes and seconds must be 2-digit numbers between 00&ndash;59.</li>
<li>UTC on its own is Universal Co-ordinated Time (formerly known as Greenwich
Mean Time). UTC can be followed by a plus (<code>+</code>) or minus
(<code>-</code>) and a number between 1 and 12 to specify one of the
Earth&rsquo;s 24 timezones.</li></ul></dd>

<dt><code>status</code></dt>
<dd>Valid values for <code>status</code> are:
<ul><li><code>publish</code>: publish the post (default)</li>
<li><code>private</code>: privately publish the post</li>
<li><code>pending</code>: mark the post as pending editorial approval</li>
<li><code>draft</code>: save the post as a draft</li>
<li><code>trash</code>: move the post to the trash</li></ul></dd>

<dt><code>format</code></dt>
<dd>Supported values for <code>format</code> are:
<code>standard</code> (default); <code>aside</code>; <code>audio</code>;
<code>chat</code>; <code>gallery</code>; <code>image</code>; <code>link</code>;
<code>quote</code>; <code>status</code>; and <code>video</code>. Read this
article on <a href="https://en.support.wordpress.com/posts/post-formats/">post
formats</a> for more information.<br /><br /></dd>

<dt><code>sticky</code></dt>
<dd>The <code>sticky</code> header can either have a value of
<code>0</code> (default) for not sticky, or <code>1</code> for <a
href="https://en.support.wordpress.com/post-visibility/#sticky-posts">sticky</a>.<br /><br /></dd>

<dt><code>comments</code> and <code>pingbacks</code></dt>
<dd><a href="https://en.support.wordpress.com/comments/">Comments</a> and <a
href="https://en.support.wordpress.com/comments/pingbacks/">pingbacks</a> can
either be <code>open</code> or <code>closed</code>.<br /><br /></dd>

<dt><code>categories</code> and <code>tags</code></dt>
<dd>At least 1 <a href="https://en.support.wordpress.com/posts/categories/">category</a> is
required. <a href="https://en.support.wordpress.com/posts/tags/">Tags</a> are
optional, but recommended.</dd></dl>

The header block is followed by the body, which holds the contents of your blog
post. The body must be written in markdown and will be passed to Pandoc for
conversion to HTML.

[back to top][top]

## Passing Shortcodes Through to WordPress.com

A [shortcode] is a WordPress-specific code that allows you to do everything from
listing source code to embedding a [YouTube] video. WordPress.com
_expands_ shortcodes into HTML (ie, it replaces a shortcode with HTML relevant
to a specific shortcode). Below is an example of a YouTube shortcode:

```
[youtube https://www.youtube.com/watch?v=_htxLyl9pqg]
```

Shortcodes must be on a line by themselves. This is a problem because Pandoc
knows nothing of shortcodes and treats the above example as a paragraph,
converting it into the following HTML:

```
<p>[youtube https://www.youtube.com/watch?v=_htxLyl9pqg]</p>
```

To work around this limitation, you can wrap shortcodes inside a special HTML
comment as in this example:

```
<!-- shortcode
[youtube https://www.youtube.com/watch?v=_htxLyl9pqg]
/shortcode -->
```

Pandoc ignores the contents of the HTML comment and passes it through unchanged.
`<!-- shortcode` and `/shortcode -->` must be on lines by themselves as in the
above example.

cmdPost reads in Pandoc&rsquo;s HTML output, optimises it for WordPress.com, and
strips out all occurrences of the opening and closing comment tags, which
exposes the shortcode for expansion by WordPress.com.

[back to top][top]

## Preventing Autolinking of Email Addresses and URLs

WordPress.com automatically hyperlinks any email addresses or URLs in a blog
post (except inside a `<pre> ... </pre>` block or between
`<code> ... </code>` tags). For example:

```
someone@example.com
```

becomes:

```
<a href="mailto:someone@example.com">someone@example.com</a>
```

Not always what you want! :grimacing:

To prevent this _autolinking_, you could substitute `&#64;` for `@` in an
email address (or `&#58;` for the `:` in a URL).

Unfortunately, Pandoc &ldquo;helpfully&rdquo; replaces character entities with
the characters they represent. To work around this, cmdPost allows you to
specify a literal character entity like this:

```
someone&amp;#64;example.com
```

This will pass through Pandoc unchanged. cmdPost then changes `&amp;` back to
`&`, leaving just:

```
someone&#64;example.com
```

which WordPress.com will not autolink.

[back to top][top]

## Emoji Support

Support for [emojis][wiki-emoji] is provided by Pandoc&rsquo;s [emoji
extension][pandoc-emoji]. To insert an emoji, all you have to do is type the
name of an emoji (in lowercase letters) between two colons. For example:

- `:smile:` becomes :smile:
- `:frog:` becomes :frog:
- `:bathtub:` becomes :bathtub:

Pandoc will substitute the emoji name for the emoji it represents. In the
unlikely event you want to write a literal string like `:helicopter:`, simply
escape the colons with backslashes like so: `\:helicopter\:`

Emoji substitutions will not be made inside a [code block][verbatim-blocks], or
[inline verbatim text][verbatim-inline].

Refer to this [Emoji Cheat Sheet][emoji-cheat-sheet] for a list of supported
emojis.

[back to top][top]

## cmdPost Usage Example

Let&rsquo;s say you&rsquo;ve signed up for a free WordPress.com blog with the
following details:

- username: `john`
- password: `John&rsquo;sPa$$word#17`
- URL: `https://johnsjournal.wordpress.com/`.

Please note that this is a fictitious example and any resemblance to real
usernames or URLs is coincidental.

First, create a folder called `John&rsquo;s Journal`, or `johnsjournal`, or just
`jj` if you like. Just so long as the name of the folder is enough to remind you
of the blog it is associated with.

Next, create a `blog.cfg` file in your blog folder with the following contents:

```
username: john
password: John&rsquo;sPa$$word#17
endpoint: https://johnsjournal.wordpress.com/xmlrpc.php
```

After that, open a new file in your favourite text editor, and write a test
post like this:

```
---
title: Test Post
date: 2017/06/07 16:30:00
status: publish
categories: Announcements
tags: cmdpost, more tag, test post, wordpress.com
---

This is a test post to check that cmdPost is set up correctly and working
properly.

Only content before the [`<!--more-->` tag][more-tag-help] will be displayed on
the blog&rsquo;s front page...

<!--more more &raquo;-->

The rest of the post goes here.

Happy blogging! :smile:

[more-tag-help]: https://en.support.wordpress.com/more-tag/
```

save the file as `testpost.md`.

If you want to preview `testpost.md` before posting it  with cmdPost, enter:

```
postprev testpost.md
```

at the cmd prompt.

An HTML preview of `testpost.md` should open in your default browser. It
won&rsquo;t be an exact replica of how the post will appear on WordPress.com,
but it will give you some idea of what the final result will look like, and
gives you the chance to correct any mistakes in your markdown, spelling errors,
poor grammar, etc.

When you&rsquo;re satisfied that `testpost.md` is ready for posting, enter the
following at the cmd prompt:

```
cmdPost testpost.md
```

Assuming all went well, the message:

```
new post created
```

will be displayed.

Lastly, go to your WordPress.com blog and check that your new post has been published and is displayed correctly.

[back to top][top]

[top]: #top
[wp]: https://wordpress.com/
[windows]: http://windows.microsoft.com/
[markdown]: http://daringfireball.net/projects/markdown/
[pandoc]: http://www.pandoc.org/
[html]: http://www.w3.org/html/
[xml]: http://www.w3.org/TR/REC-xml/
[shortcode]: https://en.support.wordpress.com/shortcodes/
[YouTube]: https://www.youtube.com/
[XmlRpcEndpoint]: https://codex.wordpress.org/XML-RPC_Support
[emoji-cheat-sheet]: https://www.webpagefx.com/tools/emoji-cheat-sheet/
[pandoc-emoji]: http://pandoc.org/MANUAL.html#extension-emoji
[wiki-emoji]: https://en.wikipedia.org/wiki/Emoji
[verbatim-blocks]: http://pandoc.org/MANUAL.html#verbatim-code-blocks
[verbatim-inline]: http://pandoc.org/MANUAL.html#verbatim
[files]: #blog-folders-and-special-files
[config]: #blog-configuration-files
[posts]: #blog-posts
[shortcodes]: #passing-shortcodes-through-to-wordpresscom
[autolinking]: #preventing-autolinking-of-email-addresses-and-urls
[emojis]: #emoji-support
[example]: #cmdpost-usage-example
