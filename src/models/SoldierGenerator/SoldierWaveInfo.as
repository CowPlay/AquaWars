/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/6/13
 * Time: 10:00 AM
 * To change this template use File | Settings | File Templates.
 */
package models.SoldierGenerator
{
import gameObjects.Houses.Base.HouseBase;

public class SoldierWaveInfo
{

    /*
     * Fields
     */
    //TODO: make properties
    public var generatedSoldierRest:uint;
    public var generatedSoldierCount:uint;

    public var owner:HouseBase;
    public var target:HouseBase;

    public var timeGeneratedLast:Number;
    public var timeGeneratedFrequency:Number;


    /*
     * Properties
     */

    /*
     * Methods
     */

    //! Default constructor
    public function SoldierWaveInfo()
    {
        timeGeneratedLast = 0.0;
        timeGeneratedFrequency = 0.0;
    }
}
}
