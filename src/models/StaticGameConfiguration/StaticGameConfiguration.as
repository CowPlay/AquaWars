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

import gameObjects.BaseView;
import gameObjects.Forge.Forge;

import gameObjects.House.EHouseType;
import gameObjects.House.House;
import gameObjects.Stable;
import gameObjects.Tower.Tower;

public class StaticGameConfiguration
{
    private static var _enemyDamage: int = 1;
    private static var _playerDamage: int = 1;



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

    public static function getLevelMax(house: House):int
    {
        var result:int = 0;

        if (house is Tower || house is Forge || house is Stable)
        {
            switch (house.type)
            {
                case EHouseType.EHT_PLAYER:
                case EHouseType.EHT_ENEMY:
                {
                    result = 1;

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
        }
        else if (house is House)
        {
            switch (house.type)
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
        }

        return result;
    }

    public static function getHouseSquare(house: House):Rectangle
    {
        var result:Rectangle;

        if (house is Tower)
        {
            result = new Rectangle(2, 1, 3, 3);
        }
        else
        {
            switch (house.type)
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
                    result = new Rectangle(1, 0, 4, 4);

                    break;
                }
                default :
                {
                    GameUtils.assert(false);
                    break;
                }

            }

        }

        return result;
    }

    public static function getHouseExitPosition(house: House):Point
    {
        var result:Point;

        if (house is Tower)
        {
            result = new Point(-1, 3);
        }
        else
        {
            switch (house.type)
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
                    result = new Point(3, 4);

                    break;
                }
                default :
                {
                    GameUtils.assert(false);
                    break;
                }
            }

        }



        return result;
    }

    public static function getNormalSoldierDamage(owner: EHouseType):int
    {
        var result: int;
        switch (owner)
        {
            case EHouseType.EHT_ENEMY:
            {
                result = _enemyDamage;
                break;
            }

            case EHouseType.EHT_PLAYER:
            {
                result = _playerDamage;
                break;
            }

            case EHouseType.EHT_NEUTRAL:
            {
                result = 1;
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


    public static function setNormalEnemyDamage(damage: int):void
    {
        _enemyDamage = damage;
    }

    public static function setNormalPlayerDamage(damage: int):void
    {
        _playerDamage = damage;
    }

}
}
