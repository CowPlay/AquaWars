/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/4/13
 * Time: 2:10 AM
 * To change this template use File | Settings | File Templates.
 */
package models.StaticGameConfiguration
{
import flash.geom.Point;
import flash.geom.Rectangle;

import gameObjects.House.EHouseType;

public class StaticGameConfiguration
{
    public static function getSoldiersCountMax(houseType:EHouseType, houseLevel:int):int
    {
        var result:int = 0;

        switch (houseType)
        {
            case EHouseType.EHT_ENEMY:
            {
                result = 50;

                break;
            }
            case EHouseType.EHT_PLAYER:
            {
                result = 50;

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

    public static function getLevelMax(houseType:EHouseType):int
    {
        var result:int = 0;

        switch (houseType)
        {
            case EHouseType.EHT_PLAYER:
            case EHouseType.EHT_ENEMY:
            {
                result = 2;

                break;
            }
            case EHouseType.EHT_NEUTRAL:
            {
                result = 0;

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

    public static function getHouseSquare(houseType:EHouseType, level:uint):Rectangle
    {
        var result:Rectangle;

        switch (houseType)
        {
            case EHouseType.EHT_PLAYER:
            {
                result = new Rectangle(1, 0, 4, 4);
                break;
            }
            case EHouseType.EHT_ENEMY:
            {
                result = new Rectangle(3, 0, 3, 4);
                break;
            }
            case EHouseType.EHT_NEUTRAL:
            {
                result = new Rectangle(0, 0, 4, 4);

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

    public static function getHouseExitPosition(houseType:EHouseType, level:uint):Point
    {
        var result:Point;

        switch (houseType)
        {
            case EHouseType.EHT_PLAYER:
            {
                result = new Point(3, 4);
                break;
            }
            case EHouseType.EHT_ENEMY:
            {
                result = new Point(-1, 2);
                break;
            }
            case EHouseType.EHT_NEUTRAL:
            {
                result = new Point(0, 0);

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

}
}
