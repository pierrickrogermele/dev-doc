import javax.swing.*;  

public class HelloWorld extends JFrame {//inheriting JFrame  

	HelloWorld(){  
		JButton b=new JButton("HelloWorld");//create button  
		b.setBounds(130,100,100, 40);  

		add(b);//adding button on frame  
		setSize(400,500);  
		setLayout(null);  
		setVisible(true);  
	}  

	public static void main(String[] args) {  
		new HelloWorld();  
	}
}  
