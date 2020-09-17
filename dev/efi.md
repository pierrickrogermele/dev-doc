# EFI

 * [EFI 1.1 Shell Command Reference Manul](https://manuais.iessanclemente.net/images/a/a6/EFI-ShellCommandManual.pdf).
 * [UEFI Shell commands](https://techlibrary.hpe.com/docs/iss/proliant_uefi/UEFI_TM_030617/GUID-D7147C7F-2016-0901-0A6D-000000000E1B.html).

Display attributes of directory:
```bash
attrib fs0:\
```

Change current filesystem:
```sh
fs0:
```

List directory content:
```sh
ls
```

Change current directory:
```bash
cd mydir
```

Get help:
```sh
help
help mycommand
```

Remove a file:
```sh
rm myfile
```

Redirect an output:
```sh
help > help.txt
```
