import java.awt.*;  

class HelloWorld {

	/////////////////
	// CONSTRUCTOR //
	/////////////////

	HelloWorld() {
		Frame f=new Frame();  

		Button b=new Button("Hello World");
		b.setBounds(30,50,80,30);  

		f.add(b);  
		f.setSize(300,300);  
		f.setLayout(null);  
		f.setVisible(true);  
	}

	//////////
	// MAIN //
	//////////

	public static void main(String args[]) {
		HelloWorld f=new HelloWorld();  
	}
}
