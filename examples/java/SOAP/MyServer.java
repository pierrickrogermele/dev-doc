package SOAP;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.xml.ws.Endpoint;

@WebService()
public class MyServer {

	@WebMethod()
	public int getAnInteger() { return 2; }

	@WebMethod()
	public String getAString() { return "coucou"; }

	public static void main(String[] args) {

		Endpoint.publish("http://localhost:8080/WebServiceExample/myserver",
		                 new MyServer());
	}
}
