/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/30/13
 * Time: 5:37 PM
 * To change this template use File | Settings | File Templates.
 */
package models.ResourceManager
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;
import gameObjects.Houses.Tower.Tower;

//import gameObjects.Soldier.ESoldierType;

public class ResourceManager
{
    /*
     * Scene
     */

    [Embed(source="../../../assets/scene.swf", symbol="background")]
    private static var _sceneBackground:Class;





     /*
      * AuraClass
      */
    [Embed(source="../../../assets/scene.swf", symbol="aura_house_player")]
    private static var _auraHousePlayer:Class;
    [Embed(source="../../../assets/scene.swf", symbol="aura_house_enemy")]
    private static var _auraHouseEnemy:Class;


    /*
     * ArrowViewClass
     */
    [Embed(source="../../../assets/scene.swf", symbol="arrow_0001")]
    private static var _selectedArrow:Class;

    /*
     * indicatorLevelUpClass
     */
    [Embed(source="../../../assets/scene.swf", symbol="indicator_levelUp")]
    private static var _indicatorLevelUp:Class;


     /*
      * pause class
      */

    [Embed(source="../../../assets/scene.swf", symbol="pause_stop")]
    private static var _pauseStop:Class;
    [Embed(source="../../../assets/scene.swf", symbol="pause_play")]
    private static var _pausePlay:Class;




     /*
      * TowerBulletClass
      */
    [Embed(source="../../../assets/scene.swf", symbol="enemy_bullet")]
    private static var _bulletClassEnemy:Class;
    [Embed(source="../../../assets/scene.swf", symbol="player_bullet")]
    private static var _bulletClassPlayer:Class;
    [Embed(source="../../../assets/scene.swf", symbol="neutral_bullet")]
    private static var _bulletClassNeutral:Class;


    //! Default constructor
    public function ResourceManager()
    {
    }


    public static function getBulletClassByOwner(owner:Tower):Class
    {
        var result:Class;

        switch (owner.ownerType)
        {
            case EHouseOwner.EHO_ENEMY:
            {
                result = _bulletClassEnemy;
                break;
            }

            case EHouseOwner.EHO_PLAYER:
            {
                result = _bulletClassPlayer;
                break;
            }

            case EHouseOwner.EHO_NEUTRAL:
            {
                result = _bulletClassNeutral;
                break;
            }

            default :
            {
                Debug.assert(false);
            }

        }

        return result;

    }

    public static function getSceneBackground():Class
    {
        return _sceneBackground;
    }

    //! Returns house view by house type, owner type and house level
    public static function getHouseViewClass(house:HouseBase):Class
    {
        Debug.assert(house != null);

        var result:Class;

        switch (house.type)
        {
            case EHouseType.EHT_BARRACKS:
            {
                result = ResourceManagerHouseBarracks.getBarracksViewClass(house);
                break;
            }

            case EHouseType.EHT_STABLE:
            {
                result = ResourceManagerHouseStable.getStableViewClass(house);
                break;
            }

            case EHouseType.EHT_TOWER:
            {
                result = ResourceManagerHouseTower.getTowerViewClass(house);
                break;
            }

            case EHouseType.EHT_SMITHY:
            {
                result = ResourceManagerHouseTower.getTowerViewClass(house);
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

    public static function getHouseAura(ownerType:EHouseOwner):Class
    {
        var result:Class;

        switch (ownerType)
        {
            case EHouseOwner.EHO_NEUTRAL:
            case EHouseOwner.EHO_ENEMY:
            {
                result = _auraHouseEnemy;
                break;
            }
            case EHouseOwner.EHO_PLAYER:
            {
                result = _auraHousePlayer;
                break;
            }
            default:
            {
                Debug.assert(false);
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


    public static function get PauseStopClass():Class
    {
        return _pauseStop;
    }

    public static function get PausePlayClass():Class
    {
        return _pausePlay;
    }
}
}
