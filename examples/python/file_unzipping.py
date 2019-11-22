#!/usr/bin/env python3

import gzip
import shutil

                logging.getLogger(__name__).debug("Unzipping file \"%s\" into \"%s\"..." % (path, unzip_path))
                with gzip.open(path, 'rb') as f_in:
                    with open(unzip_path, buffering=0, mode='wb') as f_out:
                        while True:
                            b = f_in.read(1024)
                            print(str(b))
                            if b is None or len(b) == 0:
                                break
                            f_out.write(b)
                            f_out.flush()
                        #shutil.copyfileobj(f_in, f_out)
