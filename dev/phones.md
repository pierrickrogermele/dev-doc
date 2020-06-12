PHONES
======

 * [What is an IMEI number?](http://www.cellular.co.za/ieminumbers.htm).

## SMS

 * [UNDERSTANDING SMS: Practitioner’s Basics](https://mobileforensics.files.wordpress.com/2007/06/understanding_sms.pdf).
 * SMS: [The 7 bit default alphabet](http://holman.id.au/apps/ipsms/default_alphabet.html).

### SMS SIZE

In GSM environments, an SMS message can contain up to 140 bytes (standard 8-bit bytes) of message data.

When you send a text message, as long as the text only contains characters that are included in the GSM 7-bit character set (see http://www.nowsms.com/discus/messages/1/1103.html for the table), 160 7-bit characters are compressed into 140 8-bit bytes to produce the 160 character limit that we are so familiar with.

(Note: 160 * 7 = 140 * 8)

If you want to send a message that contains characters that are not part of the GSM 7-bit character set, such as Chinese, Arabic, Thai, Cyrillic, etc., then the text needs to be encoded in Unicode UCS-2 format where each message is limited to 70 16-bit characters. (70 * 16 = 140 * 8)

If a message is larger than 140 8-bit bytes, then there are segmentation and reassembly standards defined, where a single logical message can be sent over the air using multiple physical SMS messages. The receiving client then has the ability to reassemble the segmented message so that it again appears as a single message on the receiving device.

### SMS encoding & length

7 bit -> 160 chars
8 bit -> 140 chars
16 bit UCS2 -> 70 chars

## Symbian

 * [Step-to-step tutorial : HOW TO get a signed version of FExplorer](http://www.gosymbian.com/forum/viewtopic.php?t=757).
 * [DLL contains uninitialised data - this wasn't a problem on WINS](http://www.programgo.com/article/7851351038/).

### Strings and buffers

 * [Using Symbain OS String Descriptors](http://www.codeproject.com/Articles/9716/Using-Symbain-OS-String-Descriptors).

```cpp
HBufC *text = HBufC::NewLC(120); // new buffer, added to cleanup stack
CleanupStack::PopAndDestroy(text); // to free the buffer
CleanupStack::Pop(text); // to keep the buffer in memory and return from a function for instance
```

### OS version

Using `User::Version()`:
```cpp
TVersion version;
version = User::Version();
TBuf<100> data;
data.Copy(version.Name());

iEikonEnv->AlertWin(data);
```
On Nokia 6620, you get `1.02(422)`.

Using user agent string:
```cpp
HBufC8* userAgent = HBufC8::NewLC(160);
userAgent = SysUtil::UserAgentStringL();

iVersion = HBufC::NewL(userAgent->Length()); // iVersion is of type HBufC*
iVersion->Des().Copy(userAgent->Des());
```
This will show you the whole system string info. OS version in string format you must search the string in order to get to the correct version.
For Nokia 3650: `Nokia3650/1.0 SymbianOS/6.1 Series60/1.2 Profile/MIDP-1.0 Configuration/CLDC-1.0`.
For Nokia 6620: `Nokia6620/2.0 (4.22.1) SymbianOS/7.0s Series60/2.1 Profile/MIDP-2.0 Configuration/CLDC-1.0`.
For Nokia N90:  `NokiaN90-1/2.0530.3.5 Series60/2.8 Profile/MIDP-2.0 Configuration/CLDC-1.1`.

Finally, you can use `HAL::Get()` with the attribute `EDeviceFamilyRev` (or `DeviceFamilyRev` in a sis file) to get the OS version.
```cpp
TInt version;
HAL::Get(HAL::EDeviceFamilyRev, version)
version is in hexa (0x700 for 7.0, 0x610 for 6.1, ...)
```
For Nokia 3650: `1552` (`0x610`).
For Nokia 6620: `1` (why ?).
For Nokia N90:  `1792` (`0x700`).

### etel BGSM

```cpp
#ifndef __ETELBGSM_H__
#define __ETELBGSM_H__

#include <etel.h>

const int KGsmMaxTelNumberSize = 21;

class RSmsStorage
{
  public:
  enum TStatus
  {
    ESmsBearerGprsOnly,
    ESmsBearerCircuitSwitchedOnly,
    ESmsBearerGprsPreferred,
    ESmsBearerCircuitSwitchedPreferred
  };
};

#endif
```

### etel GPRS

```cpp
#ifndef ETELGPRS_H
#define ETELGPRS_H

#include <etel.h>
class RGprs : public RTelSubSessionBase
{
  public:
  enum TSmsBearer
  {
    ESmsBearerGprsOnly,
    ESmsBearerCircuitSwitchedOnly,
    ESmsBearerGprsPreferred,
    ESmsBearerCircuitSwitchedPreferred
  };
};

#endif
```

### Font

Class               | Description
------------------- | -----------------
`TTypefaceSupport`  | Description of font.
`TTypeface`         | Description of font.
`CFont`             | Font object.
`CFbsTypefaceStore` | Access to system font store.

Number of fonts in the system:
```cpp
iCoeEnv->ScreenDevice()->NumTypefaces();
```

Get font number i:
```cpp
iCoeEnv->ScreenDevice()->TypefaceSupport(typeface, i);
```

Add font file:
```cpp
iCoeEnv->ScreenDevice()->AddFile();
```

Remove font file:
```cpp
iCoeEnv->ScreenDevice()->RemoveFile();
```

Create font instance:
```cpp
iFont = iCoeEnv->CreateScreenFontL(fontSpec);
```

Release font instance:
```cpp
iCoeEnv->ReleaseScreenFontL(iFont);
```

If we copy font directly to `C:\System\Fonts`:

 * We have to restart phone in order for system to load this font.
 * When we want to remove this font with FExplorer, it says : 'Already in Use' and does not remove it. We have first to change directory name (e.g.: `C:\System\Fonts` --> `C:\System\Fonts2`), then remove the font file, then rename back the directory.
