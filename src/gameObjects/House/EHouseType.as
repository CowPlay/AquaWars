/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 6:18 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.House
{
public final class EHouseType
{
    public static const EHT_PLAYER:EHouseType = new EHouseType();
    public static const EHT_ENEMY:EHouseType = new EHouseType();
    public static const EHT_NEUTRAL:EHouseType = new EHouseType();


    public function EHouseType()
    {
    }

    public function toString():String
    {
        var result:String;

        switch (this)
        {
            case EHT_PLAYER:
            {
                result = "EHT_PLAYER";
                break;
            }
            case EHT_ENEMY:
            {
                result = "EHT_ENEMY";
                break;
            }
            case EHT_NEUTRAL:
            {
                result = "EHT_NEUTRAL";
                break;
            }
            default :
            {
                GameUtils.assert(false);
                break;
            }
        }

        return result;
    }
}
}
