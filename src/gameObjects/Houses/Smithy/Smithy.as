/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/14/13
 * Time: 4:16 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Houses.Smithy
{
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

public class Smithy extends HouseBase
{
    /*
     * Properties
     */

    public override function get type():EHouseType
    {
        return EHouseType.EHT_SMITHY;
    }

    /*
     * Methods
     */

    //! If owner type == null -> type = neutral
    public function Smithy(soldierCount:int, type:EHouseOwner = null)
    {
        super(soldierCount, type);
    }
}
}
