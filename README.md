#cmdPost

If you can answer 'Yes!' to the following questions:

* Are you running [Windows] (XP or later)?
* Do you write in [markdown] and use [Pandoc] to convert to [HTML]?
* Have you admin access to a [WordPress.com][wp] blog?

then Command Post (cmdPost for short) is for you!

##What Is It?

cmdPost opens a markdown file specified by the user and looks for a specially
formatted header block at the start of the file. It scans the header for _meta
information_ such as title, date, status, etc.

The program then passes the body of the file (ie, the markdown content) to
Pandoc for conversion to HTML.

Lastly, the meta information extracted from the header block along with the HTML
is assembled into an [XML] document, which is posted to the WordPress.com blog
specified by the user.

##Is That All?

Okay, there's a bit more to it than that! :smile: But I don't want to get bogged
down in detail in this README. More details to follow in future releases.

[windows]: http://windows.microsoft.com/
[markdown]: http://daringfireball.net/projects/markdown/
[pandoc]: http://www.pandoc.org/
[wp]: https://wordpress.com/
[html]: http://www.w3.org/html/
[xml]: http://www.w3.org/TR/REC-xml/
