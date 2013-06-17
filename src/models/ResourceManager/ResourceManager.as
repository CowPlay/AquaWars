/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/30/13
 * Time: 5:37 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.House.EHouseType;

//import gameObjects.Soldier.ESoldierType;

public class ResourceManager
{
    /*
     * Scene
     */

    [Embed(source="../../../assets/scene.swf", symbol="background")]
    private static var _sceneBackground:Class;

    /*
     * House classes
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
     * Soldier classes
     */
    [Embed(source="../../../assets/scene.swf", symbol="soldier_enemy_01")]
    private static var _soldierClassEnemy:Class;

    [Embed(source="../../../assets/scene.swf", symbol="soldier_player_01")]
    private static var _soldierClassPlayer:Class;


    [Embed(source="../../../assets/scene.swf", symbol="aura_house_player")]
    private static var _auraHousePlayer:Class;
    [Embed(source="../../../assets/scene.swf", symbol="aura_house_enemy")]
    private static var _auraHouseEnemy:Class;

    [Embed(source="../../../assets/scene.swf", symbol="arrow_0001")]
    private static var _selectedArrow:Class;

    [Embed(source="../../../assets/scene.swf", symbol="indicator_levelUp")]
    private static var _indicatorLevelUp:Class;


    //! Default constructor
    public function ResourceManager()
    {
    }

    public static function getSceneBackground():Class
    {
        return _sceneBackground;
    }

    public static function getHouseClassByTypeAndLevel(type:EHouseType, level:int):Class
    {
        var result:Class;

        switch (type)
        {
            case EHouseType.EHT_ENEMY:
            {
                result = getHouseClassEnemy(level);
                break;
            }
            case EHouseType.EHT_PLAYER:
            {
                result = getHouseClassPlayer(level);
                break;
            }
            case EHouseType.EHT_NEUTRAL:
            {
                result = _houseClassPlayerLevel1;
                break;
            }
            default :
            {
                //! Not implemented
                GameUtils.assert(false);
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
                GameUtils.assert(false);
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
                GameUtils.assert(false);
                break;
            }
        }

        return result;

    }

    public static function getSoldierClassByOwnerTypeAndLevel(type:EHouseType, level:int = 1):Class
    {
        var result:Class;

        switch (type)
        {
            case EHouseType.EHT_ENEMY:
            {
                result = _soldierClassEnemy;
                break;
            }
            case EHouseType.EHT_PLAYER:
            {
                result = _soldierClassPlayer;
                break;
            }
            case EHouseType.EHT_NEUTRAL:
            {
                GameUtils.assert(false);
                break;
            }
            default:
            {
                //! Not implemented
                GameUtils.assert(false);
                break;
            }
        }

        return result;
    }

    public static function getHouseAura(houseType:EHouseType):Class
    {
        var result:Class;

        switch (houseType)
        {
            case EHouseType.EHT_ENEMY:
            {
                result = _auraHouseEnemy;
                break;
            }
            case EHouseType.EHT_PLAYER:
            {
                result = _auraHousePlayer;
                break;
            }
            default:
            {
                GameUtils.assert(false);
                break;
            }
        }

        return result;

    }


    public static function getSelectedArrow():Class
    {
        return _selectedArrow;
    }



    public static function getIndicatorLevelUpClass():Class
    {
        return _indicatorLevelUp;
    }

}
}
