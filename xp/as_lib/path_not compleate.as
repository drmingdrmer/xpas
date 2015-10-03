/**
 @class os.path
 @description various utils methods concerning OS path
 @author Alessandro Crugnola
 @version 1.0

 example usage
 import os.path
 a = quothttp://www.sephiroth.it/test/python/quot
 b = quotwww.sephiroth.it/test/PHP/sepy.php?id=2ampcat=PHP_MYSQLquot
 result = path.joina,b
**/
class os.path
{
        /**
         @method os.path.join
         @description Calculates the relative path from two absolute paths given
         @params pathA String
         @params pathB String
         @returns String
        */
        static public function join(pathA:String,pathB:String):String
        {
                var flag:Boolean = true
                var sPath1:String = pathA
                var sPath2:String = pathB
                var aPath1:Array
                var aPath2:Array
                var aPath3:Array
                var index:Number = 0
                var nCount:Number
                var altPath:Array = new Arrayquot./quot
                ifpathA.indexOfquothttp://quot == -1 and pathA.indexOfquothttps://quot == -1{
                        sPath1 = quothttp://quot add pathA
                }
                ifpathB.indexOfquothttp://quot == -1 and pathB.indexOfquothttps://quot == -1{
                        sPath2 = quothttp://quot add pathB
                }
                aPath1 = sPath1.splitquot//quot
                aPath2 = sPath2.splitquot//quot
                aPath1[1] = aPath1[1].splitquot/quot
                aPath2[1] = aPath2[1].splitquot/quot
                ifaPath1[0].toLowerCase != aPath2[0].toLowerCase{ return pathB }
                ifaPath1[1][0].toLowerCase != aPath2[1][0].toLowerCase{ return pathB }
                aPath1 = aPath1[1].slice1
                aPath2 = aPath2[1].slice1
                aPath3 = aPath2.slice
                nCount = aPath1.length
                whileindex < aPath1.length and flag{
                        ifaPath1[0] == aPath2[index]{
                                aPath1.shift
                                aPath3.shift
                                index
                        } else {
                                flag = false
                        }
                }
                whileindex < nCount{
                        altPath.pushquot../quot
                        index
                }
                return altPath.joinquotquot add aPath3.joinquot/quot
        }
}