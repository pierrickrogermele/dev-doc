class AbstractFactory {

	////////////
	// OBJECT //
	////////////

	class Object {
		public void do_something() {
			System.out.println("Hello I'm Object mother class !");
		}
	}

	//////////////
	// OBJECT 1 //
	//////////////

	class Object1 extends Object {
		public void do_something() { System.out.println("Hello I'm Object1 !"); }
	}

	//////////////
	// OBJECT 2 //
	//////////////

	class Object2 extends Object {
		public void do_something() { System.out.println("Hello I'm Object2 !"); }
	}

	/////////////
	// FACTORY //
	/////////////

	class Factory {
		public Object getObject(int param) {
			if (param % 2 == 0)
				return new Object1();
			else
				return new Object2();
		}
	}

	//////////
	// MAIN //
	//////////

	public static void main(String[] args) {
		Factory f = new Factory();
			Object o1 = f.getObject(1);
			Object o2 = f.getObject(4);
			o1.do_something();
			o2.do_something();
	}

}
