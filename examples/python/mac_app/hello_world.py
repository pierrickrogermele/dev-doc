import sys
from PyQt4 import Qt
app = Qt.QApplication(sys.argv)
hello = Qt.QLabel("Hello World !")
hello.show()
app.exec_()
