/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:17 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

public class ResourceManagerHouseTower
{

    /*
     * Fields
     */

    [Embed(source="../../../assets/scene.swf", symbol="neutral_tower")]
    private static var _towerClassNeutral:Class;

    [Embed(source="../../../assets/scene.swf", symbol="player_tower")]
    private static var _towerClassPlayer:Class;

    [Embed(source="../../../assets/scene.swf", symbol="enemy_tower")]
    private static var _towerClassEnemy:Class;

    /*
     * Methods
     */

    public static function getTowerViewClass(owner:HouseBase):Class
    {
        var result:Class;

        switch (owner.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = _towerClassEnemy;
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = _towerClassPlayer;
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = _towerClassNeutral;
                break;
            }
            default :
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
