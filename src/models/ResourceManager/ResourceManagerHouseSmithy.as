/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:18 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

public class ResourceManagerHouseSmithy
{

    /*
    / Fields
    */

    [Embed(source="../../../assets/scene.swf", symbol="neutral_forge")]
    private static var _smithyClassNeutral:Class;
    [Embed(source="../../../assets/scene.swf", symbol="player_forge")]
    private static var _smithyClassPlayer:Class;
    [Embed(source="../../../assets/scene.swf", symbol="enemy_forge")]
    private static var _smithyClassEnemy:Class;


    /*
    / Methods
     */

    public static function getSmithyViewClass(owner:HouseBase):Class
    {
        var result:Class;

        switch (owner.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = _smithyClassEnemy;
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = _smithyClassPlayer;
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = _smithyClassNeutral;
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
