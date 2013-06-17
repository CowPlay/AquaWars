/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
package models.GameConfiguration.Soldier
{
import gameObjects.Houses.Base.EHouseOwner;

public class GameConfigurationSoldierDamage
{
    public static function getNormalSoldierDamage(owner:EHouseOwner):int
    {
        var result:int;

        switch (owner)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = 1;
                break;
            }

            case EHouseOwner.EHO_PLAYER:
            {
                result = 1;
                break;
            }

            case EHouseOwner.EHO_NEUTRAL:
            {
                result = 1;
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
