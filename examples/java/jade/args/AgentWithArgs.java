import jade.core.Agent;
import jade.core.AID;

public class AgentWithArgs extends Agent {

	// Put agent initializations here
	protected void setup() {

		// Printout a welcome message
		System.out.println("Hello! Agent "+getAID().getName()+" is ready.");

		// Get the title of the book to buy as a start-up argument
		Object[] args = getArguments();
		if (args != null && args.length > 0) {
			for (Object arg: args)
				System.out.println("Agent " + getAID().getName() + " received argument \"" + (String)arg + "\".");
		}
		else {
			// Make the agent terminate immediately
			System.out.println("No arguments specified");
		}
		this.doDelete();
	}

//	private final java.util.concurrent.Semaphore sem = new java.util.concurrent.Semaphore(1);
	private static int count = 3;

	class ContainerKiller extends Thread {

		private jade.wrapper.ContainerController ctnctrl = null;

		public ContainerKiller(jade.wrapper.ContainerController c) {
			this.ctnctrl = c;
			System.err.println("ContainerKiller thread created.");
		}

		public void run() {
			try {
				sleep(1000); // waiting for the agent to finish properly.
			} catch(InterruptedException e) {
				System.err.println("Impossible to sleep.");
			}
			System.err.println("ContainerKiller thread run.");
			try {
				this.ctnctrl.kill();
				System.err.println("Container killed.");
			}
			catch(jade.wrapper.StaleProxyException e) {
				System.err.println("Unable to kill container.");
			}
		}
	}

	// Put agent clean-up operations here
	protected synchronized void takeDown() {

		System.out.println("Agent "+getAID().getName()+" terminating.");

		--this.count; // count down the number of agents still running.
		System.out.println("COUNT = " + count);
		if (this.count == 0) // no agents are running, except this one, which will soon terminate to run its takeDown() method.
			new Thread(new ContainerKiller(this.getContainerController())).start();
	}
}
