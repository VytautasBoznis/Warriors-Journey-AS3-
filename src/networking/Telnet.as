package  networking
{
	import flash.events.*;
	import flash.net.Socket;
	
	/**
	 * Used to connect to the data servers and sinchronize data.
	 * @author Ideo
	 * @version 1.0v
	 */
	
	public class Telnet 
	{
		private var socket : Socket;
		private var hostURL : String;
		private var hostPort : int;

		private var authed : Boolean;
		private var scores : Vector.<int> = new Vector.<int>;
		
		public function Telnet()
		{
			hostURL = "62.80.237.198";
			hostPort = 27000;
			
			socket = new Socket();
			
			socket.addEventListener(Event.CONNECT, connectHandler); 
			socket.addEventListener(Event.CLOSE, closeHandler); 
			socket.addEventListener(ErrorEvent.ERROR, errorHandler); 
			socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); 
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler); 
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, secErrorHandler);
		
			try
			{
				trace("Starting Connection!");
				socket.connect(hostURL,hostPort);
			}
			catch (error:Error)
			{
				trace(error.message);
			}
		}
		
		public function connectHandler(event :Event) :void
		{			
			trace("Connected!"+event.toString);
		}
		
		public function dataHandler(event : ProgressEvent) :void
		{
			trace("New Data!");
			
			readMessage(socket.readUTFBytes( socket.bytesAvailable ));
		}
		
		public function ioErrorHandler(event : IOErrorEvent) : void
		{
			trace("ERROR: " + event.toString);
		}
		
		public function secErrorHandler(event : SecurityErrorEvent) : void
		{
			trace("ERROR: " + event.toString);
		}
		
		public function errorHandler(event : Error) : void
		{
			trace("ERROR: " + event.message);
		}
		
		public function closeHandler(event : Event) : void
		{
			trace("Connection Closed"+event.toString);
		}
		
		public function sendMessage(message : String) : void
		{
			if (socket && socket.connected)
			{
				socket.writeUTFBytes(message+"\n");
				socket.flush();
				trace("send: " + message);
			}
		}
		
		public function readMessage(message : String) : void
		{
			trace("new message :" + message);
			
			if (message.charAt(0) == "/") //a command is received
			{
				var command : String = "";
				var lastChar : int = 1;

				while (message.charAt(lastChar) != ";")
				{
					command += message.charAt(lastChar);
					lastChar++;
				}
				
				lastChar++;//now its on the first ;
				
				if (command == "login")
					login();
				else if (command == "authOK")
					authed = true;
				else if (command == "gBestS" || command == "pBestS")
				{ 
					var numberString : String = "";
					
					 // finds how much scores there will be
					if (command.charAt(lastChar+1) != ";")//runs if it's a two digit number
					{
						numberString += message.charAt(lastChar);
						lastChar++;
						numberString += message.charAt(lastChar);
						lastChar++;
					}
					else//runs if it's a single digit number
					{
						numberString += message.charAt(lastChar);
						lastChar++;
					}
					
					lastChar++;
					
					var number : int = parseInt(numberString);
					var i : int;

					var score : String;
					scores = new Vector.<int>;
					
					for (i = 0; i < number; i++)
					{
						score = "";
						while (message.charAt(lastChar) != ";")
						{
							score += message.charAt(lastChar);
							lastChar++;
						}
						scores.push(parseInt(score));
						lastChar++;
					}
				}
				else if (command == "newScores")
					sendMessage("/getSp;10;");
				else
					trace("unknow command : " + command);
			}
			else
				trace("unknown message");
		}
		
		public function login() : void
		{
			var id : int;
			
			id = 50001040;
			
			sendMessage("/aID;" + id + ";");
		}
		
		public function sendScore(score : Number) :void
		{
			if (!authed)
				login();
			
			var scoreInt : int = score;			
			sendMessage("/addS;" + scoreInt + ";");
		}
		
		public function getBestScores(number : int,global : Boolean) : Vector.<int>
		{
			if (global)
				sendMessage("/getSg;10;");
			else
				sendMessage("/getSp;10;");
				
			return scores;
		}
	}

}