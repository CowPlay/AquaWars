/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/14/13
 * Time: 5:42 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects
{
import gameObjects.House.EHouseType;
import gameObjects.House.House;

public class Stable extends House
{
    public function Stable(type: EHouseType, soldierCount: int)
        {
            super (type, soldierCount);
        }
}
}

