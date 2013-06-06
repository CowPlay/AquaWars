/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/4/13
 * Time: 2:10 AM
 * To change this template use File | Settings | File Templates.
 */
package models.StaticGameConfiguration
{
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
                result = 5;

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

}
}
