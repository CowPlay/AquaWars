/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/17/13
 * Time: 1:49 PM
 * To change this template use File | Settings | File Templates.
 */
package models.GameConfiguration.House
{
import flash.geom.Rectangle;

import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

public class GameConfigurationHouseFoundation
{
    public static function getHouseFoundation(house:HouseBase):Rectangle
    {
        Debug.assert(house != null);

        var result:Rectangle;

        switch (house.type)
        {
            case EHouseType.EHT_TOWER:
            {
                result = getHouseFoundationTower(house);
                break;
            }
            case EHouseType.EHT_BARRACKS:
            {
                result = getHouseFoundationBarracks(house);
                break;
            }
            case EHouseType.EHT_SMITHY:
            {
                result = getHouseFoundationSmithy(house);

                break;
            }
            case EHouseType.EHT_STABLE:
            {
                result = getHouseFoundationStable(house);

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


    private static function getHouseFoundationBarracks(house:HouseBase):Rectangle
    {
        var result:Rectangle;

        switch (house.ownerType)
        {
            case EHouseOwner.EHO_PLAYER:
            {
                result = new Rectangle(1, 0, 4, 4);
                break;
            }
            case EHouseOwner.EHO_ENEMY:
            {
                result = new Rectangle(3, 0, 3, 4);
                break;
            }
            case EHouseOwner.EHO_NEUTRAL:
            {
                result = new Rectangle(1, 0, 4, 4);
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

    private static function getHouseFoundationTower(house:HouseBase):Rectangle
    {
        var result:Rectangle;

        switch (house.ownerType)
        {
            case  EHouseOwner.EHO_PLAYER:
            {
                result = new Rectangle(2, 1, 3, 3);

                break;
            }
            case  EHouseOwner.EHO_ENEMY:
            {
                result = new Rectangle(2, 1, 3, 3);

                break;
            }
            case  EHouseOwner.EHO_NEUTRAL:
            {
                result = new Rectangle(2, 1, 3, 3);

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

    private static function getHouseFoundationSmithy(house:HouseBase):Rectangle
    {
        var result:Rectangle;

        switch (house.ownerType)
        {
            case  EHouseOwner.EHO_PLAYER:
            {
                result = new Rectangle(2, 1, 3, 3);
                break;
            }
            case  EHouseOwner.EHO_ENEMY:
            {
                result = new Rectangle(2, 1, 3, 3);
                break;
            }
            case  EHouseOwner.EHO_NEUTRAL:
            {
                result = new Rectangle(2, 1, 3, 3);
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


    private static function getHouseFoundationStable(house:HouseBase):Rectangle
    {
        var result:Rectangle;

        switch (house.ownerType)
        {
            case  EHouseOwner.EHO_PLAYER:
            {
                result = new Rectangle(2, 1, 3, 3);
                break;
            }
            case  EHouseOwner.EHO_ENEMY:
            {
                result = new Rectangle(2, 1, 3, 3);
                break;
            }
            case  EHouseOwner.EHO_NEUTRAL:
            {
                result = new Rectangle(2, 1, 3, 3);
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
