import com.sun.net.httpserver.*;
import java.net.*;
import java.nio.charset.*;
import java.io.*;
import java.util.*;
import java.util.concurrent.*;
import java.time.*;
import java.time.format.*;

class RestWebService {
	public static final DateTimeFormatter TIMESTAMP_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	public static String timestamp() {
		return LocalDateTime.now().format(TIMESTAMP_FORMATTER);
	}
	public static void main (String[] args) {
		RestWebService.starter();
	}
	public static void starter() {
		try {
			HttpServer server = HttpServer.create(new InetSocketAddress(5050), 0);
			server.createContext("/api/v1", new RootHandler());
			server.createContext("/api/v1/help", new HelpHandler());
			server.createContext("/api/v1/ping", new PingHandler());
			server.createContext("/api/v1/exit", new ExitHandler(server));
			server.createContext("/api/v1/pwd", new PwdHandler());
			server.setExecutor(Executors.newCachedThreadPool());
			System.out.println(RestWebService.timestamp() + " # REST API server started at port " + server.getAddress());
			server.start();
		} catch (Exception _e) {
			_e.printStackTrace();
		}
	}

	public static abstract class AbstractEndpointHandler implements HttpHandler {
		public void handle(HttpExchange _exchange) {
			String httpMethod = _exchange.getRequestMethod();
			System.out.println();
			System.out.println(RestWebService.timestamp());
			System.out.println("HTTP method: " + httpMethod);
			System.out.println("HTTP path: " + _exchange.getRequestURI().getPath());
			System.out.println("HTTP query: " + _exchange.getRequestURI().getQuery());
			UriParser uriParser = UriParser.makeParser(_exchange);
			if ("GET".equalsIgnoreCase(httpMethod)) {
				this.doGet(_exchange, uriParser);
			} else if ("POST".equalsIgnoreCase(httpMethod)) {
				this.doPost(_exchange, uriParser);
			} else if ("PUT".equalsIgnoreCase(httpMethod)) {
				this.doPut(_exchange, uriParser);
			} else if ("DELETE".equalsIgnoreCase(httpMethod)) {
				this.doDelete(_exchange, uriParser);
			} else {
				this.sendResponse(_exchange, 405, "HTTP method " + httpMethod + " is not supported.");
			}
		}
		public void doGet(HttpExchange _exchange, UriParser _uriParser) {
			this.sendResponse(_exchange, 405, "GET method is not supported for this endpoint.");
		}
		public void doPost(HttpExchange _exchange, UriParser _uriParser) {
			this.sendResponse(_exchange, 405, "POST method is not supported for this endpoint.");
		}
		public void doPut(HttpExchange _exchange, UriParser _uriParser) {
			this.sendResponse(_exchange, 405, "PUT method is not supported for this endpoint.");
		}
		public void doDelete(HttpExchange _exchange, UriParser _uriParser) {
			this.sendResponse(_exchange, 405, "DELETE method is not supported for this endpoint.");
		}
		public void sendResponse(HttpExchange _exchange, int _statusCode, String _responseText) {
			_exchange.getResponseHeaders().set("Content-Type", "text/plain; charset=utf-8");
			byte[] responseBytes = _responseText.getBytes(StandardCharsets.UTF_8);
			try {
				_exchange.sendResponseHeaders(_statusCode, responseBytes.length);
			} catch (Exception _e) {
				_e.printStackTrace();
			}
			try (OutputStream outputStream = _exchange.getResponseBody()) {
				outputStream.write(responseBytes);
			} catch (Exception _e) {
				_e.printStackTrace();
			}
		}
	}

	public static class RootHandler extends AbstractEndpointHandler {
		public void doGet(HttpExchange _exchange, UriParser _uriParser) {
			if (_uriParser.pathElements.length < 4 || _uriParser.pathElements[3].isEmpty()) {
				this.sendResponse(_exchange, 200, HelpHandler.getHelp(""));
			} else {
				this.sendResponse(_exchange, 400, "Unknown command: " + _uriParser.pathElements[3]);
			}
		}
	}

	public static class HelpHandler extends AbstractEndpointHandler {
		public void doGet(HttpExchange _exchange, UriParser _uriParser) {
			String responseBody;
			if (_uriParser.pathElements.length > 4 && _uriParser.pathElements[4] != null && !_uriParser.pathElements[4].isEmpty()) {
				responseBody = HelpHandler.getHelp(_uriParser.pathElements[4]);
			} else {
				responseBody = HelpHandler.getHelp("");
			}
			this.sendResponse(_exchange, 200, responseBody);
		}
		public static String getHelp(String _command) {
			String command = _command == null ? "" : _command.toLowerCase();
			switch (command) {
			case "":
				return "Welcome to Glibs's Java learning web service!\n\n"
						+ "Use commands:\n"
						+ "EXIT (post) -- stop current web service.\n"
						+ "HELP (get) -- get this help, or help/<command> for command-specific help.\n"
						+ "PING (get) -- test connection.\n"
						+ "        More details on: help/ping.\n"
						+ "PWD (get) -- shows current directory of web service.\n";
			case "ping":
				return "Query options:\n\n"
						+ "delay=<seconds> -- returns response with delay. <seconds> must be integer.\n";
			case "exit":
				return "Stops the running web service. No parameters.\n";
			case "help":
				return "Shows this help, or help for a specific command: help/<command>.\n";
			default:
				return "No help for command '" + _command + "' available.";
			}
		}
	}

	public static class PingHandler extends AbstractEndpointHandler {
		public void doGet(HttpExchange _exchange, UriParser _uriParser) {
			int responseStatus = 200;
			String responseBody = "PING is OK!";
			String delayParam = _uriParser.getQueryParam("delay");
			if (delayParam != null && !delayParam.isEmpty()) {
				int delay = 0;
				boolean validDelay = true;
				try {
					delay = Integer.parseInt(delayParam);
				} catch (NumberFormatException _e) {
					validDelay = false;
				}
				if (!validDelay) {
					responseStatus = 400;
					responseBody = "Incorrect delay parameter in URL (/api/v1/ping?delay=<seconds>). Integer expected.";
				} else if (delay > 0) {
					try {
						Thread.sleep(delay * 1000);
					} catch (Exception _e) {
						_e.printStackTrace();
					}
				}
			}
			this.sendResponse(_exchange, responseStatus, responseBody);
		}
	}

	public static class PwdHandler extends AbstractEndpointHandler {
		public void doGet(HttpExchange _exchange, UriParser _uriParser) {
			this.sendResponse(_exchange, 200, "Current directory: " + System.getProperty("user.dir"));
		}
	}

	public static class ExitHandler extends AbstractEndpointHandler {
		HttpServer server = null;
		public ExitHandler(HttpServer _server) {
			this.server = _server;
		}
		public void doPost(HttpExchange _exchange, UriParser _uriParser) {
			System.out.println("Got EXIT command.");
			this.sendResponse(_exchange, 200, "Stopping server...");
			this.server.stop(2);
		}
	}

	public static class UriParser {
		HttpExchange exchange;
		String requestPath;
		String requestQuery;
		public String[] pathElements;
		public ArrayList<String[]> queryParamList = new ArrayList<>();
		public UriParser(HttpExchange _exchange) {
			this.exchange = _exchange;
		}
		public void runParse() {
			this.requestPath = this.exchange.getRequestURI().getRawPath();
			this.requestQuery = Objects.toString(this.exchange.getRequestURI().getRawQuery(), "");
			if (this.requestPath != null && !this.requestPath.isEmpty()) {
				String[] pathEncodedElements = this.requestPath.split("/");
				this.pathElements = new String[pathEncodedElements.length];
				for (int i = 0; i < pathEncodedElements.length; i++) {
					this.pathElements[i] = URLDecoder.decode(pathEncodedElements[i], StandardCharsets.UTF_8);
				}
			} else {
				this.pathElements = new String[0];
			}
			if (this.requestQuery != null && !this.requestQuery.isEmpty()) {
				String[] queryParamTextList = this.requestQuery.split("&");
				for (String _queryParam : queryParamTextList) {
					String[] queryParamKeyValue = _queryParam.split("=");
					String[] queryParamKeyValueDecoded = new String[queryParamKeyValue.length];
					for (int i = 0; i < queryParamKeyValue.length; i++) {
						queryParamKeyValueDecoded[i] = URLDecoder.decode(queryParamKeyValue[i], StandardCharsets.UTF_8);
					}
					this.queryParamList.add(queryParamKeyValueDecoded);
				}
			}
		}
		public String getQueryParam(String _key) {
			for (String[] _kv : this.queryParamList) {
				if (_kv.length > 0 && _kv[0].equalsIgnoreCase(_key)) {
					return _kv.length > 1 ? _kv[1] : "";
				}
			}
			return null;
		}
		public static UriParser makeParser(HttpExchange _exchange) {
			UriParser uriParser = new UriParser(_exchange);
			uriParser.runParse();
			return uriParser;
		}
	}
}
