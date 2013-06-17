/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/4/13
 * Time: 2:10 AM
 * To change this template use File | Settings | File Templates.
 */
package models.GameConfiguration.House
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

public class GameConfigurationHouseLevel
{
    /*
     * Level max
     */

    public static function getLevelMax(house:HouseBase):int
    {
        Debug.assert(house != null);

        var result:int = 0;

        switch (house.type)
        {
            case EHouseType.EHT_TOWER:
            {
                result = getLevelMaxTower(house);
                break;
            }
            case EHouseType.EHT_BARRACKS:
            {
                result = getLevelMaxBarracks(house);
                break;
            }
            case EHouseType.EHT_SMITHY:
            {
                result = getLevelMaxSmithy(house);
                break;
            }
            case EHouseType.EHT_STABLE:
            {
                result = getLevelMaxStable(house);
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

    private static function getLevelMaxBarracks(house:HouseBase):int
    {
        var result:int = 0;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            case EHouseOwner.EHO_ENEMY:
            {
                result = 2;

                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = 0;

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

    private static function getLevelMaxTower(house:HouseBase):int
    {
        var result:int = 0;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            case EHouseOwner.EHO_ENEMY:
            {
                result = 1;

                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = 0;

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

    private static function getLevelMaxSmithy(house:HouseBase):int
    {
        var result:int = 0;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            case EHouseOwner.EHO_ENEMY:
            {
                result = 1;

                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = 0;

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

    private static function getLevelMaxStable(house:HouseBase):int
    {
        var result:int = 0;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            case EHouseOwner.EHO_ENEMY:
            {
                result = 1;

                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = 0;

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

    /*
     * Level
     */
}
}
