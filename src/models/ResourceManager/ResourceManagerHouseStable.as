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

public class ResourceManagerHouseStable
{
    /*
     * Fields
     */
    [Embed(source="../../../assets/scene.swf", symbol="neutral_stable")]
    private static var _stableClassNeutral:Class;
    [Embed(source="../../../assets/scene.swf", symbol="player_stable")]
    private static var _stableClassPlayer:Class;
    [Embed(source="../../../assets/scene.swf", symbol="enemy_stable")]
    private static var _stableClassEnemy:Class;

    /*
     * Methods
     */


    public static function getStableViewClass(owner:HouseBase):Class
    {
        var result:Class;

        switch (owner.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = _stableClassEnemy;
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = _stableClassPlayer;
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = _stableClassNeutral;
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
