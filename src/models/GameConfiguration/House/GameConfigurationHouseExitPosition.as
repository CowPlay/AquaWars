/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 1:58 PM
 * To change this template use File | Settings | File Templates.
 */
package models.GameConfiguration.House
{
import flash.geom.Point;

import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

public class GameConfigurationHouseExitPosition
{
    public static function getHouseExitPosition(house:HouseBase):Point
    {
        Debug.assert(house != null);

        var result:Point;

        switch (house.type)
        {
            case EHouseType.EHT_TOWER:
            {
                result = new Point(-1, 3);
                break;
            }
            case EHouseType.EHT_BARRACKS:
            {
                result = getHouseExitPositionBarracks(house);
                break;
            }
            case EHouseType.EHT_SMITHY:
            {
                result = new Point(-1, 3);
                break;
            }
            case EHouseType.EHT_STABLE:
            {
                result = new Point(-1, 3);
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

    private static function getHouseExitPositionBarracks(house:HouseBase):Point
    {
        var result:Point;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            {
                result = new Point(3, 4);
                break;
            }
            case EHouseOwner.EHO_ENEMY:
            {
                result = new Point(-1, 2);
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = new Point(3, 4);

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
