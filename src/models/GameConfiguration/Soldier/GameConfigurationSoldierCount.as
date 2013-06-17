/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:04 PM
 * To change this template use File | Settings | File Templates.
 */
package models.GameConfiguration.Soldier
{
import gameObjects.Houses.Base.EHouseOwner;

public class GameConfigurationSoldierCount
{
    public static function getSoldiersCountMax(houseType:EHouseOwner, houseLevel:int):int
    {
        var result:int = 0;

        switch (houseType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = 50;

                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = 50;

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
