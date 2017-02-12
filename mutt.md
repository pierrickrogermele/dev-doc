MUTT
====

## macOS configuration

 * [Getting started with Mutt on OSX](http://www.lucianofiandesio.com/getting-started-with-mutt-on-osx).
 * [How to integrate iCloud contact, calendar, or email accounts on the BlackBerry 10 smartphone](http://support.blackberry.com/kb/articleDetail?ArticleNumber=000033812).

## Saving an email

Piping email: hit `|` for running the pipe command, and type `cat >myfile.eml`. The email will be written into myfile.eml with full header and all attachments.

Note: an eml file can be parsed for extracting text and/or attachments with munpack (mpack package) or ripmime.

## Trash

Installing with trash patch:
``` {.bash}
brew tap pierrickrogermele/prm
brew install --with-trash-patch pierrickrogermele/prm/mutt
```

See <https://dev.mutt.org/trac/wiki/MuttFaq/Folder> for handling trash without the patch.

## Configuration file

```muttrc
set from=pkroger@free.fr		# sender address

set record= "~/Mail/sent" # where to save sent messages
set copy= yes # actually save sent messages
```

Alias:
```muttrc
alias myaliasname some.address@somewhere.earth another.address@near.there
```

## Command

Command | Description
------- | --------------------------
`c`     | Change mailbox.
`d`     | Delete a mail.
`t`     | Tag mail.
`T`     | Tag several mails by matching a string.
`;d`    | Delete all tagged mails.
`$`     | Write changes to mailbox.
`r`     | Reply to a mail.
`g`     | Reply to all recipients.

## Bind key

Create key shortcut for refreshing inbox:
```muttrc
bind index "^" imap-fetch-mail
```

## Macros

Defining a macro:
```muttrc
macro index gi "<change-folder>=INBOX<enter>" "Go to inbox"
```

Defining a macro with a space inside the string command:
```muttrc
macro index gt "<change-folder>=Deleted<quote-char> Items<enter>" "Go to trash"
macro index gs "<change-folder>=[Gmail].Sent<tab><enter>" "Go to Sent Mail"
```

## Opening links

To open links contained in an email, install `urlview` (`brew install urlview`) and use `Ctrl-b` inside an email.

## Attachments

To see attachments, use mailcap (see below on how to create a `.mailcap` file). Press `m` for forcing opening an attachment with mailcap.

Create a `.mailcap` file in `$HOME` with a line for each MIME TYPE:
```mailcap
text/html; links -force-html %s
```

On MacOS-X:
```mailcap
text/html; HOME= open -a firefox %s; nametemplate=%s.html
application/pdf; HOME= open -a preview %s
application/*; view-attachment -c $HOME/Downloads %s
image/*; view-attachment -c $HOME/Downloads %s
```
`HOME=` is here to avoid `open` to add `$HOME` to the file path.

MIME attachment filenames are displayed as `=?iso-8859-1?Q`.

The filename is encoded in the deprecated RFC 2047 (which has been superseded by RFC 2231); this is commonly produced by Microsoft Outlook, and some other MUAs.
Decode these filenames by setting this parameter in mutt:
```muttrc
set rfc2047_parameters
```

## Search

 * [Searching in Mutt](https://www.gl.ciw.edu/static/users/rcohen/mutt/manual-6.html).

Key      | Description
-------- | ----------------------------
`/`      | Search.
`<Esc>/` | Reverse search.

Pattern           | Description
----------------- | ------------------------------
`blabla`          | Search message subject.   
`~s blabla`       | Search message subject.   
`~b blabla`       | Search message body.
`~t blabla`       | Search recipients.
`~c blabla`       | Search carbon-copy recipients.
`~f blabla`       | Search sender.
`~f toto ~t titi` | Search toto in sender and titi in recipients.

## Flags

Flags used in list of messages.

Flag | Description
---- | ------------------------------------------------
`D`  | Message is deleted (is marked for deletion).
`d`  | Message have attachments marked for deletion.
`N`  | Message is new.
`O`  | Message is old.
`r`  | Message has been replied to.
`K`  | Contains a PGP public key.
`P`  | Message is PGP encrypted.
`S`  | Message is PGP signed, and the signature is succesfully verified.
`s`  | Message is PGP signed.
`!`  | Message is flagged.
`*`  | Message is tagged.
`+`  | Message is to you and you only.
`T`  | Message is to you, but also to or cc'ed to others.
`C`  | Message is cc'ed to you.
`F`  | Message is from you.
`L`  | Message is sent to a subscribed mailing list.

Some of the status flags can be turned on or off using `set-flag` and `clear-flag`.
