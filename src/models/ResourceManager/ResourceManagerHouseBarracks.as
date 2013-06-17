/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 2:16 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

public class ResourceManagerHouseBarracks
{
    /*
     / Fields
     */

    /*
     * Barracks classes
     */
    [Embed(source="../../../assets/scene.swf", symbol="house_player_barracks_1")]
    private static var _houseClassNeutral:Class;


    /*
     * Enemy
     */

    [Embed(source="../../../assets/scene.swf", symbol="house_enemy_barracks_1")]
    private static var _houseClassEnemyLevel1:Class;
    [Embed(source="../../../assets/scene.swf", symbol="house_enemy_barracks_2")]
    private static var _houseClassEnemyLevel2:Class;

    /*
     * Player
     */

    [Embed(source="../../../assets/scene.swf", symbol="house_player_barracks_1")]
    private static var _houseClassPlayerLevel1:Class;
    [Embed(source="../../../assets/scene.swf", symbol="house_player_barracks_2")]
    private static var _houseClassPlayerLevel2:Class;


    /*
     /Methods
     */

    public static function getBarracksViewClass(house:HouseBase):Class
    {
        var result:Class;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = getHouseClassEnemy(house.level);
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = getHouseClassPlayer(house.level);
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = _houseClassPlayerLevel1;
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

    private static function getHouseClassEnemy(level:int):Class
    {
        var result:Class;

        switch (level)
        {
            case 1:
            {
                result = _houseClassEnemyLevel1;
                break;

            }
            case 2:
            {
                result = _houseClassEnemyLevel2;
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

    private static function getHouseClassPlayer(level:int):Class
    {
        var result:Class;

        switch (level)
        {
            case 1:
            {
                result = _houseClassPlayerLevel1;
                break;

            }
            case 2:
            {
                result = _houseClassPlayerLevel2;
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
