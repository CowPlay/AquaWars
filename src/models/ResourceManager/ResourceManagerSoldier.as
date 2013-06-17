/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:45 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

public class ResourceManagerSoldier
{

    /*
     / Fields
     */

    /*
     * Soldier classes
     */
    [Embed(source="../../../assets/scene.swf", symbol="soldier_enemy_01")]
    private static var _soldierClassEnemy:Class;

    [Embed(source="../../../assets/scene.swf", symbol="soldier_player_01")]
    private static var _soldierClassPlayer:Class;

    /*
     / Methods
     */

    public static function getSoldierClassByOwner(house:HouseBase):Class
    {
        Debug.assert(house != null);

        var result:Class;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = _soldierClassEnemy;
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = _soldierClassPlayer;
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                Debug.assert(false);
                break;
            }
            default:
            {
                //! Not implemented
                Debug.assert(false);
                break;
            }
        }

        return result;
    }
}
}
