﻿/**
 * string.string 	various utils methods concerning Strings
 * 
 * @author	Alessandro Crugnola
 * @version	1.0
 */
class utils.string
{
	/**
	 * endswith	check if input string (inString) terminates with the given char/string (sChar)
	 * 
	 * @param	inString String
	 * @param	sChar String
	 * @return	Boolean
	 */
	static public function endswith(inString:String, sChar:String):Boolean
	{
		var l_index:Number = inString.lastIndexOf(sChar);
		var s_count = inString.length;
		var c_count = sChar.length;
		return (s_count - c_count == l_index);
	}
	/**
	 * startwith	check if input string (inString) begin with the given char/string (sChar)
	 * 
	 * @param	inString String
	 * @param	sChar String
	 * @return	Boolean
	 */
	static public function startswith(inString:String, sChar:String):Boolean
	{
		return inString.indexOf(sChar) == 0;
	}
	/**
	 * lstrip	trim left a string
	 * 
	 * @param	inString String
	 * @return	String
	 */
	static public function lstrip(inString:String):String
	{
		var index:Number = 0;
		while(inString.charCodeAt(index) < 33){
			index++;
		}
		return inString.substr(index)
	}
	/**
	 * rstrip	trim right a string
	 * 
	 * @param	inString String
	 * @return	String
	 */
	static public function rstrip(inString:String):String
	{
		var index:Number = inString.length - 1;
		while(inString.charCodeAt(index) < 33){
			index--;
		}
		return inString.substr(0,index + 1)
	}
	/**
	 * strip	trim a string
	 * 
	 * @param	inString String
	 * @return	String
	 */
	static public function strip(inString:String):String
	{
		return string.rstrip(string.lstrip(inString))
	}
	/**
	 * capitalize	Convert the first char of every string words in uppercase
	 * 
	 * @param	inString String
	 * @return	String
	 */	
	static public function capitalize(inString:String):String
	{
		var a:Number = 0;
		var aString:Array = inString.split(" ");
		for(a = 0; a < aString.length; a++)
		{
			aString[a] = aString[a].substring(0,1).toUpperCase() + aString[a].substring(1, aString[a].length).toLowerCase();
		}
		return aString.join(" ");
	}
	
	/**
	 * replace	replace all occurrence of a char into a string with the new char
	 * 
	 * @param	inStr String to be converted
	 * @param	oldChar String value to replace
	 * @param	newChar String new value replaced
	 * @return	String
	 */	
	static public function replace(inStr:String, oldChar:String, newChar:String):String
	{
		if(inStr == undefined or inStr == null)
		{
			return inStr;
		}
		return inStr.split(oldChar).join(newChar);
	}
	
	/**
	 * md5	encrypt a string using the MD5 crypt hash
	 * 
	 * @param	str String string to be crypted
	 * @return	String
	 */
	static public function md5(str:String):String
	{
		function safe_add(x, y)
		{
			var lsw = (x & 0xFFFF) + (y & 0xFFFF);
			var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
			return (msw << 16) | (lsw & 0xFFFF);
		}
		function rol(num, cnt)
		{
			return (num << cnt) | (num >>> (32 - cnt));
		}
		function cmn(q, a, b, x, s, t)
		{
			return safe_add(rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b);
		}
		function ff(a, b, c, d, x, s, t)
		{
			return cmn((b & c) | ((~b) & d), a, b, x, s, t);
		}
		function gg(a, b, c, d, x, s, t)
		{
			return cmn((b & d) | (c & (~d)), a, b, x, s, t);
		}
		function hh(a, b, c, d, x, s, t)
		{
			return cmn(b ^ c ^ d, a, b, x, s, t);
		}
		function ii(a, b, c, d, x, s, t)
		{
			return cmn(c ^ (b | (~d)), a, b, x, s, t);
		}
		function coreMD5(x)
		{
			var a = 1732584193;
			var b = -271733879;
			var c = -1732584194;
			var d = 271733878;
			for (var i = 0; i < x.length; i += 16)
			{
				var olda = a;
				var oldb = b;
				var oldc = c;
				var oldd = d;
				a = ff(a, b, c, d, x[i + 0], 7, -680876936);
				d = ff(d, a, b, c, x[i + 1], 12, -389564586);
				c = ff(c, d, a, b, x[i + 2], 17, 606105819);
				b = ff(b, c, d, a, x[i + 3], 22, -1044525330);
				a = ff(a, b, c, d, x[i + 4], 7, -176418897);
				d = ff(d, a, b, c, x[i + 5], 12, 1200080426);
				c = ff(c, d, a, b, x[i + 6], 17, -1473231341);
				b = ff(b, c, d, a, x[i + 7], 22, -45705983);
				a = ff(a, b, c, d, x[i + 8], 7, 1770035416);
				d = ff(d, a, b, c, x[i + 9], 12, -1958414417);
				c = ff(c, d, a, b, x[i + 10], 17, -42063);
				b = ff(b, c, d, a, x[i + 11], 22, -1990404162);
				a = ff(a, b, c, d, x[i + 12], 7, 1804603682);
				d = ff(d, a, b, c, x[i + 13], 12, -40341101);
				c = ff(c, d, a, b, x[i + 14], 17, -1502002290);
				b = ff(b, c, d, a, x[i + 15], 22, 1236535329);
				a = gg(a, b, c, d, x[i + 1], 5, -165796510);
				d = gg(d, a, b, c, x[i + 6], 9, -1069501632);
				c = gg(c, d, a, b, x[i + 11], 14, 643717713);
				b = gg(b, c, d, a, x[i + 0], 20, -373897302);
				a = gg(a, b, c, d, x[i + 5], 5, -701558691);
				d = gg(d, a, b, c, x[i + 10], 9, 38016083);
				c = gg(c, d, a, b, x[i + 15], 14, -660478335);
				b = gg(b, c, d, a, x[i + 4], 20, -405537848);
				a = gg(a, b, c, d, x[i + 9], 5, 568446438);
				d = gg(d, a, b, c, x[i + 14], 9, -1019803690);
				c = gg(c, d, a, b, x[i + 3], 14, -187363961);
				b = gg(b, c, d, a, x[i + 8], 20, 1163531501);
				a = gg(a, b, c, d, x[i + 13], 5, -1444681467);
				d = gg(d, a, b, c, x[i + 2], 9, -51403784);
				c = gg(c, d, a, b, x[i + 7], 14, 1735328473);
				b = gg(b, c, d, a, x[i + 12], 20, -1926607734);
				a = hh(a, b, c, d, x[i + 5], 4, -378558);
				d = hh(d, a, b, c, x[i + 8], 11, -2022574463);
				c = hh(c, d, a, b, x[i + 11], 16, 1839030562);
				b = hh(b, c, d, a, x[i + 14], 23, -35309556);
				a = hh(a, b, c, d, x[i + 1], 4, -1530992060);
				d = hh(d, a, b, c, x[i + 4], 11, 1272893353);
				c = hh(c, d, a, b, x[i + 7], 16, -155497632);
				b = hh(b, c, d, a, x[i + 10], 23, -1094730640);
				a = hh(a, b, c, d, x[i + 13], 4, 681279174);
				d = hh(d, a, b, c, x[i + 0], 11, -358537222);
				c = hh(c, d, a, b, x[i + 3], 16, -722521979);
				b = hh(b, c, d, a, x[i + 6], 23, 76029189);
				a = hh(a, b, c, d, x[i + 9], 4, -640364487);
				d = hh(d, a, b, c, x[i + 12], 11, -421815835);
				c = hh(c, d, a, b, x[i + 15], 16, 530742520);
				b = hh(b, c, d, a, x[i + 2], 23, -995338651);
				a = ii(a, b, c, d, x[i + 0], 6, -198630844);
				d = ii(d, a, b, c, x[i + 7], 10, 1126891415);
				c = ii(c, d, a, b, x[i + 14], 15, -1416354905);
				b = ii(b, c, d, a, x[i + 5], 21, -57434055);
				a = ii(a, b, c, d, x[i + 12], 6, 1700485571);
				d = ii(d, a, b, c, x[i + 3], 10, -1894986606);
				c = ii(c, d, a, b, x[i + 10], 15, -1051523);
				b = ii(b, c, d, a, x[i + 1], 21, -2054922799);
				a = ii(a, b, c, d, x[i + 8], 6, 1873313359);
				d = ii(d, a, b, c, x[i + 15], 10, -30611744);
				c = ii(c, d, a, b, x[i + 6], 15, -1560198380);
				b = ii(b, c, d, a, x[i + 13], 21, 1309151649);
				a = ii(a, b, c, d, x[i + 4], 6, -145523070);
				d = ii(d, a, b, c, x[i + 11], 10, -1120210379);
				c = ii(c, d, a, b, x[i + 2], 15, 718787259);
				b = ii(b, c, d, a, x[i + 9], 21, -343485551);
				a = safe_add(a, olda);
				b = safe_add(b, oldb);
				c = safe_add(c, oldc);
				d = safe_add(d, oldd);
			}
			return [a, b, c, d];
		}
		function binl2hex(binarray)
		{
			var hex_tab = "0123456789abcdef";
			var str = "";
			for (var i = 0; i < binarray.length * 4; i++)
			{
				str += hex_tab.charAt((binarray[i >> 2] >> ((i % 4) * 8 + 4)) & 0xF) + hex_tab.charAt((binarray[i >> 2] >> ((i % 4) * 8)) & 0xF);
			}
			return str;
		}
		function binl2b64(binarray)
		{
			var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
			var str = "";
			for (var i = 0; i < binarray.length * 32; i += 6)
			{
				str += tab.charAt(((binarray[i >> 5] << (i % 32)) & 0x3F) | ((binarray[i >> 5 + 1] >> (32 - i % 32)) & 0x3F));
			}
			return str;
		}
		function str2binl(str)
		{
			var nblk = ((str.length + 8) >> 6) + 1;
			var blks = new Array(nblk * 16);
			for (var i = 0; i < nblk * 16; i++)
			{
				blks[i] = 0;
			}
			for (var i = 0; i < str.length; i++)
			{
				blks[i >> 2] |= (str.charCodeAt(i) & 0xFF) << ((i % 4) * 8);
			}
			blks[i >> 2] |= 0x80 << ((i % 4) * 8);
			blks[nblk * 16 - 2] = str.length * 8;
			return blks;
		}
		function strw2binl(str)
		{
			var nblk = ((str.length + 4) >> 5) + 1;
			var blks = new Array(nblk * 16);
			for (var i = 0; i < nblk * 16; i++)
			{
				blks[i] = 0;
			}
			for (var i = 0; i < str.length; i++)
			{
				blks[i >> 1] |= str.charCodeAt(i) << ((i % 2) * 16);
			}
			blks[i >> 1] |= 0x80 << ((i % 2) * 16);
			blks[nblk * 16 - 2] = str.length * 16;
			return blks;
		}
		function hexMD5(str){ return binl2hex(coreMD5(str2binl(str)))};
		function hexMD5w(str){  return binl2hex(coreMD5(strw2binl(str)))};
		function b64MD5(str){ return binl2b64(coreMD5(str2binl(str)))};
		function b64MD5w(str){ return binl2b64(coreMD5(strw2binl(str)))};
		function calcMD5(str){ return binl2hex(coreMD5(str2binl(str)))};
		return calcMD5(str);
	}
	
	/**
	 * dec2bin	convert a decimal number into binary string
	 *
	 * @param	num	Number
	 * @return	String	
	 */
	static function dec2bin(num:Number):String {
		var bin:Array = new Array();
		var result:Number = num;
		var rest:Number;
		do
		{
			rest = result%2;
			result = Math.floor(result/2);
			bin.push(rest);
		} while(result != 0);
		bin.reverse()
		return bin.join('');
	}	
	
	/**
	 * string_repeat return a string with the char repeated n times
	 *
	 * @param	st	String
	 * @param	num	Number
	 * @return	String	
	 */
	static function string_repeat(st:String, num:Number):String {
		var ret:String = '';
		for(var a = 0; a < num; a++){
			ret = ret add '' add st;
		}
		return ret;
	}	
}