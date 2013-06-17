/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 6:18 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Houses.Base
{
public final class EHouseOwner
{
    public static const EHO_PLAYER:EHouseOwner = new EHouseOwner();
    public static const EHO_ENEMY:EHouseOwner = new EHouseOwner();
    public static const EHO_NEUTRAL:EHouseOwner = new EHouseOwner();

    public function toString():String
    {
        var result:String;

        switch (this)
        {
            case EHO_PLAYER:
            {
                result = "EHO_PLAYER";
                break;
            }
            case EHO_ENEMY:
            {
                result = "EHO_ENEMY";
                break;
            }
            case EHO_NEUTRAL:
            {
                result = "EHO_NEUTRAL";
                break;
            }
            default :
            {
                Debug.assert(false);
                break;
            }
        }

        return result;
    }
}
}
