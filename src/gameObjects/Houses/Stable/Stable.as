/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/14/13
 * Time: 5:42 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Houses.Stable
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

public class Stable extends HouseBase
{
    /*
     * Properties
     */

    public override function get type():EHouseType
    {
        return EHouseType.EHT_STABLE;
    }

    /*
     * Methods
     */

    //! If owner type == null -> type = neutral
    public function Stable(soldierCount:int, type:EHouseOwner = null)
    {
        super(soldierCount, type);
    }
}
}

