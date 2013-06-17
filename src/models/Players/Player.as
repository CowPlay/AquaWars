/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
package models.Players
{
import gameObjects.IDisposable;

//! Base class of all player types
public class Player    implements IDisposable
{
    public function Player()
    {
    }

    /*
     *  IDisposable
     */

    public function cleanup():void
    {

    }
}
}
