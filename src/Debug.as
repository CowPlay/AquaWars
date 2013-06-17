/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/30/13
 * Time: 5:44 PM
 * To change this template use File | Settings | File Templates.
 */
package
{


public class Debug
{
    public static function assert(expression:Boolean):void
    {
        //TODO: implement only when debug session
        if (!expression)
        {
            throw new Error("Assertion failed!");
        }
    }


}
}
