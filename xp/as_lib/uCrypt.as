import utils.string

/**
 * utils.Crypt	class with some utilities for crypting/decrypting strings
 *
 * @author	php.net user
 * @version	1.0
 */

class utils.Crypt {
	/**
	 * asc2bin	convert a string into a sequence of binary data
	 *
	 * @param	ascii	String input
	 * @return	String	bin output
	 */
	static function asc2bin (ascii:String):String{
		var binary:String = "";
		var i:Number = 0;
		var byte:String = "";
		while ( ascii.length > 0 ){
			byte = ""; 
			i = 0;
			byte = ascii.substr(0, 1);
			while ( byte != chr(i)) { 
				i++;
			}
			byte = string.dec2bin(i);
			byte = string.string_repeat("0", (8 - length(byte)) ) + byte;
			ascii = ascii.substr(1);
			binary = binary add byte;
		}
		return binary;
	} 
}
