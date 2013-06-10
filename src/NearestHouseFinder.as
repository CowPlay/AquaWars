/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 12:45 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import gameObjects.House.EHouseType;
import gameObjects.House.House;

public class NearestHouseFinder {



    //TODO: rename and rewrite
    public static function findNearestHouse(currentHouse: House, houses: Array):House
    {
        var minDistance: int = 1000;
        var result: House = null;
        for each(var house: House in houses)
        {
            if (house != currentHouse)
            {
                var a: int = Math.abs(house.currentPosition.row - currentHouse.currentPosition.row);
                var b: int = Math.abs(house.currentPosition.column - currentHouse.currentPosition.column);
                var distance: int = Math.round(Math.sqrt(a*a + b*b));
                if (distance < minDistance
                        && distance < 35
                        && house.type == EHouseType.EHT_ENEMY
                        && house.soldierCount >= (currentHouse.soldierCount + 10))
                {
                    minDistance = distance;
                    result =house ;
                }
            }
        }
        return result;
    }





    public function NearestHouseFinder() {
    }
}
}
