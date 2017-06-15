---
title: Installing cmdPost
---

## Contents

- [Keyboard Shortcuts][shortcuts]
- [Making a Home for cmdPost][cmdpost-home]
- [Downloading and Unpacking `cmdPost.zip`][download]
- [Adding cmdPost to the `PATH`][path]

## Keyboard Shortcuts

Please note that in the following sections:

- **\<Enter>** is shorthand for pressing the **Enter** key (located above the
  right **Shift** key)
- **\<AppKey>** means press the **Application** key, which is next to the right
  **Control** (or **Ctrl**) key
- **\<WinKey+R>** means hold down the **Windows** key (the one with the Windows
  logo on it), press **R** once, and release the **Windows** key
- **\<Ctrl+Shift+N>** is an instruction to hold down both the **Control** key
  and the **Shift** key, press **N** once, and then release the **Control** and
  **Shift** keys

These key combinations are known as _keyboard shortcuts_ and are much quicker
than using the mouse, once you get to know them. Study this extensive [list of
keyboard shortcuts][WinKbdShortcuts] for Windows XP and later to get started.

[back to top][top]

## Making a Home for cmdPost

Before you can download cmdPost, you must first make a home for it:

- Press **\<WinKey+R>** to open the Run dialog, enter `%UserProfile%`, and press
  **\<Enter>**. **Windows Explorer** (known as **File Explorer** on Windows10)
  should open.

- In **Windows Explorer**, press **\<Ctrl+Shift+N>** to create a new folder. The
  folder name `New Folder` should be highlighted. Type `cmdPost` and press
  **\<Enter>** to change its name.

[back to top][top]

## Downloading and Unpacking `cmdPost.zip`

Next, you have to download `cmdPost.zip` and unpack the files it contains:

- Switch to your browser and download the latest version of cmdPost from this
  URL:

  > <https://github.com/johnoregan/cmdPost/releases/download/v0.1/cmdPost.zip>

  and save the `cmdPost.zip` file in the `cmdPost` folder you just created.

- Switch back to **Windows Explorer**, open the `cmdPost` folder, select the
  `cmdPost.zip` file, press **\<AppKey>** (or **\<Shift+F10>** on a laptop), and
  select **Extract All** from the context menu.

- You may create a `blogs` folder inside the `cmdPost` folder if you wish. You
  can think of the `blogs` folder as a home for all your blog files.

[back to top][top]

## Adding cmdPost to the `PATH`

After that, it&rsquo;s a good idea to add the `cmdPost` folder to your `PATH`:

- Make sure all cmd prompt windows are closed.

- Press **\<WinKey+R>**, type `SystemPropertiesAdvanced`, and press
  **\<Enter>**.

- In the **System Properties** dialog, tab down to the **Environment
  Variables** button and press **\<Enter>**.

- In the **User Variables** section of the **Environment Variables** dialog,
  select `PATH` and add `%UserProfile%\cmdPost`. Prepend a semi-colon (`;`) if
  necessary. All entries in the `PATH` must be separated by semi-colons.

- If there is no entry for `PATH` in the **User Variables** section, create a
  new one and assign it a value as described above.

- Tab down to the **OK** button and press **\<Enter>** to close the
  **Environment Variables** dialog. And then do the same for the **System
  Properties** dialog.

And that&rsquo;s it! You&rsquo;re now ready to start using cmdPost.

[back to top][top]

[top]: #top
[WinKbdShortcuts]: https://shortcutworld.com/en/Windows
[shortcuts]: #keyboard-shortcuts
[cmdpost-home]: #making-a-home-for-cmdpost
[download]: #downloading-and-unpacking-cmdpostzip
[path]: #adding-cmdpost-to-the-path
