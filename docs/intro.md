# Introduction to cmdPost

## Table of Contents

- [What Is cmdPost?](#what-is-cmdpost)
- [What Are the Prerequisites for
  cmdPost?](#what-are-the-prerequisites-for-cmdpost)
- [What Is Markdown?](#what-is-markdown)
- [How Does cmdPost Work?](#how-does-cmdpost-work)

## What Is cmdPost?

cmdPost (pronounced &ldquo;Command Post&rdquo;) is a simple [WordPress.com][wp]
blogging client run from the [Windows] command line (`cmd`).

cmdPost is capable of creating new blog posts, or updating existing ones. In the
latter case, only the details that have changed since the last update will be
uploaded.

cmdPost enables you to keep a copy of your blog posts on your local system. This
allows you to edit posts offline and upload the changes later. It also has the
advantage of making it easier for you to migrate from one blog host to
another, or to post to multiple blogs at once.

[back to top][top]

## What Are the Prerequisites for cmdPost?

cmdPost requires the following:

- [Windows]: cmdPost was written to be compatible with Windows XP and later.

- [WordPress.com][wp]: You must own (or be able to post to) a WordPress.com
  blog. You can either sign up for a free [WordPress.com username and
  blog][signup-blog], or just a [WordPress.com username][signup-user] (you can
  always create a blog later). Choose the latter if you're joining a
  multiple-user blog, or if you're not interested in owning a blog, but
  want to follow WordPress.com blogs, leave comments, and post in the forums.

- [Pandoc]: cmdPost uses Pandoc to convert documents written in markdown (see
  next) into [HTML]. If Pandoc is not already installed on your system,
  download and install the [latest version][pandoc-latest].

- [Markdown]: If you have a working knowledge of markdown, you can [skip past
  the next section](#how-does-cmdpost-work). If not, then you need to learn
  it ([see below](#what-is-markdown)). The good news is that it's intuitive to
  use and you can master it in 15-20 minutes.

[back to top][top]

## What Is Markdown?

Markdown is a markup language with plain text formatting syntax. It is
designed to be easily converted into HTML and many other formats. In the words
of [John Gruber][gruber], the creator of markdown:

> The overriding design goal for markdown's formatting syntax is to make it as
> readable as possible. The idea is that a markdown-formatted document should
> be publishable as-is, as plain text, without looking like it's been marked
> up with tags or formatting instructions&hellip; the single biggest source of
> inspiration for markdown's syntax is the format of plain text email.
> The overriding design goal for markdown’s formatting syntax is to make it as
> readable as possible. The idea is that a markdown-formatted document should
> be publishable as-is, as plain text, without looking like it’s been marked
> up with tags or formatting instructions&hellip; the single biggest source of
> inspiration for markdown’s syntax is the format of plain text email.

Here are some useful links to help you get started:

- [Wikipedia's entry for markdown][wikipedia-markdown]: the story of markdown
  and its many offshoots
- John Gruber's original [markdown syntax][markdown-syntax]: Pandoc's syntax
  has precedence over the original syntax
- [Pandoc's markdown][pandocs-markdown]: the definitive reference
- Garen Torikian's [markdown tutorials][tutorials]: a no-nonsense guide to
  learning markdown
- [Minimalist Online Markdown Editor][mome]: your markdown side-by-side with a
  HTML preview

Happy reading! :eyeglasses:

[back to top][top]

## How Does cmdPost Work?

cmdPost opens the [markdown] file containing your blog post and looks for a
specially formatted header block at the start of the file. It scans the headers
for _meta information_ such as title, date, status, etc.

The program then passes the body of the file (ie, the markdown content) to
Pandoc for conversion to [HTML].

Lastly, the meta information extracted from the header block along with the HTML
is assembled into an [XML] document, which is posted to your WordPress.com blog.

[back to top][top]

[back to index][index]

[index]: ./
[top]: #introduction-to-cmdpost
[wp]: https://wordpress.com/
[windows]: http://windows.microsoft.com/
[markdown]: http://daringfireball.net/projects/markdown/
[html]: http://www.w3.org/html/
[xml]: http://www.w3.org/TR/REC-xml/
[gruber]: https://en.wikipedia.org/wiki/John_Gruber
[wikipedia-markdown]: https://en.wikipedia.org/wiki/Markdown
[markdown-syntax]: https://daringfireball.net/projects/markdown/syntax
[pandocs-markdown]: http://pandoc.org/MANUAL.html#pandocs-markdown
[tutorial]: http://www.markdowntutorial.com/
[mome]: http://markdown.pioul.fr/
[signup-blog]: https://signup.wordpress.com/signup/?domain=1
[signup-user]: https://signup.wordpress.com/signup/?user=1
